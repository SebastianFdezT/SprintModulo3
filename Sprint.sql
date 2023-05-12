#Primero debemos ejecutar esta parte para crear la base de datos y el usuario.
create database if not exists TeLoVendoSprint;
use TeLoVendoSprint;
create user TeLoVendoSprint@localhost identified by 'TeLoVendoSprint';
grant all privileges on TeLoVendoSprint.* to TeLoVendoSprint@localhost;

#Luego debemos crear la conexión en MySql e ingresar.


#Luego ejecutar todo lo siguiente para crear la base y poblarla.
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema telovendosprint
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema telovendosprint
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `telovendosprint` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `telovendosprint` ;

-- -----------------------------------------------------
-- Table `telovendosprint`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendosprint`.`cliente` (
  `run` VARCHAR(20) NOT NULL,
  `nombre_cliente` VARCHAR(50) NOT NULL,
  `apellido_cliente` VARCHAR(50) NOT NULL,
  `direccion` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`run`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telovendosprint`.`boleta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendosprint`.`boleta` (
  `numero_boleta` INT NOT NULL AUTO_INCREMENT,
  `precio_total` INT NOT NULL,
  `fecha_compra` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `run` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`numero_boleta`),
  INDEX `run` (`run` ASC) VISIBLE,
  CONSTRAINT `boleta_ibfk_1`
    FOREIGN KEY (`run`)
    REFERENCES `telovendosprint`.`cliente` (`run`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telovendosprint`.`proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendosprint`.`proveedor` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `nombre_empresa` VARCHAR(50) NOT NULL,
  `categoria_proveedor` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `nombre_representante` VARCHAR(50) NOT NULL,
  `apellido_representante` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_proveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telovendosprint`.`contacto_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendosprint`.`contacto_proveedor` (
  `nombre_contacto` VARCHAR(50) NOT NULL,
  `apellido_contacto` VARCHAR(50) NOT NULL,
  `teléfono_de_contacto_1` VARCHAR(20) NOT NULL,
  `teléfono_de_contacto_2` VARCHAR(20) NOT NULL,
  `proveedor_id_proveedor` INT NOT NULL,
  INDEX `fk_contacto_proveedor_proveedor1_idx` (`proveedor_id_proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_contacto_proveedor_proveedor1`
    FOREIGN KEY (`proveedor_id_proveedor`)
    REFERENCES `telovendosprint`.`proveedor` (`id_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telovendosprint`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendosprint`.`producto` (
  `sku` INT NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `precio` INT NOT NULL,
  `categoria_producto` VARCHAR(50) NOT NULL,
  `color` VARCHAR(50) NOT NULL,
  `id_proveedor` INT NOT NULL,
  PRIMARY KEY (`sku`),
  INDEX `id_proveedor` (`id_proveedor` ASC) VISIBLE,
  CONSTRAINT `producto_ibfk_1`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `telovendosprint`.`proveedor` (`id_proveedor`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telovendosprint`.`detalle_boleta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendosprint`.`detalle_boleta` (
  `cantidad` INT NOT NULL,
  `precio_items` INT NOT NULL,
  `sku` INT NOT NULL,
  `numero_boleta` INT NOT NULL,
  INDEX `sku` (`sku` ASC) VISIBLE,
  INDEX `numero_boleta` (`numero_boleta` ASC) VISIBLE,
  CONSTRAINT `detalle_boleta_ibfk_1`
    FOREIGN KEY (`sku`)
    REFERENCES `telovendosprint`.`producto` (`sku`),
  CONSTRAINT `detalle_boleta_ibfk_2`
    FOREIGN KEY (`numero_boleta`)
    REFERENCES `telovendosprint`.`boleta` (`numero_boleta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `telovendosprint`.`stock_producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `telovendosprint`.`stock_producto` (
  `cantidad` INT NOT NULL,
  `fecha_actualizacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `producto_sku` INT NOT NULL,
  INDEX `fk_stock_producto_producto1_idx` (`producto_sku` ASC) VISIBLE,
  CONSTRAINT `fk_stock_producto_producto1`
    FOREIGN KEY (`producto_sku`)
    REFERENCES `telovendosprint`.`producto` (`sku`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;





# Insertar datos de proveedores
INSERT INTO proveedor (id_proveedor, nombre_empresa, categoria_proveedor, email, nombre_representante, apellido_representante)
VALUES
(1, 'ACME Corporation', 'Tecnología', 'info@acme.com', 'John', 'Smith'),
(2, 'Widget Co.', 'Electrónica', 'info@widgetco.com', 'Sarah', 'Johnson'),
(3, 'Fancy Foods', 'Alimentos', 'sales@fancyfoods.com', 'Juan', 'Rodriguez'),
(4, 'Bayside Industries', 'Maquinaria', 'info@baysideind.com', 'David', 'Lee'),
(5, 'Global Solutions', 'Consultoría', 'info@globalsolutions.com', 'Karen', 'Taylor'),
(6, 'Elite Sports', 'Deportes', 'sales@elitesports.com', 'Michael', 'Davis'),
(7, 'Creative Designs', 'Diseño', 'info@creativedesigns.com', 'Jennifer', 'Brown'),
(8, 'E-commerce Inc.', 'Comercio electrónico', 'sales@ecommerceinc.com', 'Daniel', 'Martinez'),
(9, 'Pacific Trading Co.', 'Importación', 'info@pacifictradingco.com', 'Emily', 'Garcia'),
(10, 'Summit Marketing', 'Marketing', 'info@summitmarketing.com', 'William', 'Wilson');

# Insertar datos de productos
INSERT INTO producto (`sku`, `nombre`, `precio`, `categoria_producto`, `color`, `id_proveedor`) VALUES
(1001, 'Camiseta de algodón', 20, 'Ropa', 'Blanco', 1),
(1002, 'Pantalón vaquero', 50, 'Ropa', 'Azul', 2),
(1003, 'Zapatillas deportivas', 80, 'Calzado', 'Negro', 3),
(1004, 'Bolígrafo azul', 2, 'Papelería', 'Azul', 4),
(1005, 'Cuaderno de tapa dura', 5, 'Papelería', 'Rojo', 4),
(1006, 'Teléfono móvil', 500, 'Electrónica', 'Negro', 5),
(1007, 'Televisor LED', 800, 'Electrónica', 'Plateado', 5),
(1008, 'Reloj de pulsera', 100, 'Accesorios', 'Dorado', 6),
(1009, 'Gafas de sol', 50, 'Accesorios', 'Negro', 6),
(1010, 'Auriculares inalámbricos', 80, 'Electrónica', 'Blanco', 7),
(1011, 'Camisa de manga larga', 30, 'Ropa', 'Azul marino', 1),
(1012, 'Vestido de fiesta', 120, 'Ropa', 'Negro', 1),
(1013, 'Silla de escritorio', 70, 'Mobiliario', 'Gris', 8),
(1014, 'Mesa de comedor', 200, 'Mobiliario', 'Marrón', 8),
(1015, 'Cámara digital', 300, 'Electrónica', 'Negro', 9),
(1016, 'Altavoz Bluetooth', 50, 'Electrónica', 'Rojo', 10),
(1017, 'Perfume floral', 80, 'Belleza', 'Rosa', 1),
(1018, 'Crema hidratante', 25, 'Belleza', 'Blanco', 1),
(1019, 'Bolso de cuero', 150, 'Accesorios', 'Marrón', 6),
(1020, 'Gorra deportiva', 25, 'Ropa', 'Negro', 7);

# Insertar datos de contactos
INSERT INTO contacto_proveedor (nombre_contacto, apellido_contacto, teléfono_de_contacto_1, teléfono_de_contacto_2, proveedor_id_proveedor)
VALUES
('Mark', 'Johnson', '+1 (555) 123-4567', '+1 (555) 987-6543', 1),
('Karen', 'Smith', '+1 (555) 111-2222', '+1 (555) 333-4444', 2),
('Juan', 'Gonzalez', '+1 (555) 555-1234', '+1 (555) 555-5678', 3),
('David', 'Brown', '+1 (555) 111-5555', '+1 (555) 222-5555', 4),
('Maria', 'Rodriguez', '+1 (555) 777-8888', '+1 (555) 999-0000', 5),
('Michael', 'Lee', '+1 (555) 444-5555', '+1 (555) 666-7777', 6),
('Jennifer', 'Taylor', '+1 (555) 111-1111', '+1 (555) 222-2222', 7),
('Daniel', 'Martinez', '+1 (555) 333-3333', '+1 (555) 444-4444', 8),
('Emily', 'Garcia', '+1 (555) 555-1212', '+1 (555) 555-2121', 9),
('William', 'Wilson', '+1 (555) 777-7777', '+1 (555) 999-9999', 10);


# Insertar datos en la tabla "cliente"
INSERT INTO cliente (run, nombre_cliente, apellido_cliente, direccion)
VALUES
  ('11111111-1', 'Juan', 'Pérez', 'Calle 123'),
  ('22222222-2', 'María', 'González', 'Avenida 456'),
  ('33333333-3', 'Pedro', 'López', 'Carrera 789'),
  ('44444444-4', 'Ana', 'Martínez', 'Calle Principal'),
  ('55555555-5', 'Luis', 'Rodríguez', 'Avenida Central'),
  ('66666666-6', 'Laura', 'Hernández', 'Calle Secundaria'),
  ('77777777-7', 'Carlos', 'Sánchez', 'Avenida Norte'),
  ('88888888-8', 'Sofía', 'Torres', 'Calle Sur'),
  ('99999999-9', 'Javier', 'Ramírez', 'Calle 10'),
  ('10101010-0', 'Valentina', 'López', 'Avenida 20'),
  ('11112222-3', 'Miguel', 'Fernández', 'Calle 30'),
  ('22334455-6', 'Isabella', 'Gómez', 'Avenida 40'),
  ('55667788-9', 'Daniel', 'Silva', 'Calle 50'),
  ('99001122-3', 'Camila', 'Pérez', 'Avenida 60'),
  ('33445566-7', 'Lucas', 'Hernández', 'Calle 70'),
  ('77889900-1', 'Carolina', 'González', 'Avenida 80'),
  ('11223344-5', 'Diego', 'Sánchez', 'Calle 90'),
  ('55667789-9', 'Julia', 'Fernández', 'Avenida 100'),
  ('99001123-3', 'Gabriel', 'Martínez', 'Calle 110'),
  ('33445567-7', 'Paula', 'Silva', 'Avenida 120');
  
# Insertar datos en la tabla "stock_producto"
INSERT INTO `telovendosprint`.`stock_producto` (`cantidad`, `producto_sku`) VALUES
(10, 1001),
(20, 1002),
(15, 1003),
(50, 1004),
(30, 1005),
(5, 1006),
(12, 1007),
(8, 1008),
(25, 1009),
(15, 1010),
(40, 1011),
(18, 1012),
(22, 1013),
(10, 1014),
(7, 1015),
(0, 1016),
(14, 1017),
(30, 1018),
(3, 1019),
(10, 1020);

# Insertar datos en la tabla boleta
INSERT INTO telovendosprint.boleta (precio_total, run) VALUES
(65, '11111111-1'),
(150, '22222222-2'),
(105, '33333333-3'),
(95, '44444444-4'),
(230, '55555555-5'),
(150, '66666666-6'),
(60, '77777777-7');

# Insertar datos en la tabla detalle_boleta
INSERT INTO telovendosprint.detalle_boleta (cantidad, precio_items, sku, numero_boleta) VALUES
(2, 40, 1001, 1),
(3, 30, 1002, 1),
(1, 35, 1005, 1),
(2, 80, 1010, 2),
(1, 70, 1012, 2),
(2, 60, 1016, 3),
(1, 45, 1001, 3),
(3, 40, 1004, 4),
(2, 60, 1005, 4),
(2, 100, 1006, 5),
(1, 50, 1007, 5),
(1, 25, 1008, 5),
(2, 40, 1010, 6),
(1, 80, 1013, 6),
(3, 60, 1014, 7),
(2, 90, 1016, 7);




#- Cuál es la categoría de productos que más se repite.
SELECT categoria_producto, COUNT(categoria_producto) AS Cantidad_Repeticion  
FROM producto GROUP BY categoria_producto ORDER BY COUNT(categoria_producto) DESC LIMIT 2;


#- Cuáles son los productos con mayor stock
SELECT nombre, cantidad FROM producto INNER JOIN stock_producto ON stock_producto.producto_sku = producto.sku 
ORDER BY cantidad desc LIMIT 3;


#- Qué color de producto es más común en nuestra tienda.
SELECT color, COUNT(color) AS Cantidad_Que_Se_Repite 
FROM producto GROUP BY color ORDER BY COUNT(color) DESC LIMIT 1;


#- Cual o cuales son los proveedores con menor stock de productos.
SELECT proveedor.nombre_empresa AS PROVEEDOR_CON_MENOS_STOCK, SUM(stock_producto.cantidad) AS CANTIDAD_TOTAL
FROM proveedor 
INNER JOIN producto ON proveedor.id_proveedor = producto.id_proveedor 
INNER JOIN stock_producto ON producto.sku = stock_producto.producto_sku 
GROUP BY proveedor.id_proveedor, proveedor.nombre_empresa
ORDER BY CANTIDAD_TOTAL ASC 
LIMIT 3;


#- Cambien la categoría de productos más popular por ‘Electrónica y computación’.
set autocommit = 0;
start transaction;

UPDATE producto
SET categoria_producto = 'Electrónica y computación'
WHERE categoria_producto = (
  SELECT categoria_producto
  FROM (
    SELECT producto.categoria_producto, SUM(detalle_boleta.cantidad) AS cantidad_total
    FROM producto
    INNER JOIN detalle_boleta ON producto.sku = detalle_boleta.sku
    GROUP BY producto.categoria_producto
    ORDER BY cantidad_total DESC
    LIMIT 1
  ) AS subquery
);

# La siguiente consulta está hecha para verificar si se cambió o no la categoría, debería ejecutarse antes y después de la consulta anterior.
SELECT producto.categoria_producto, SUM(detalle_boleta.cantidad) AS cantidad_total
FROM producto
INNER JOIN detalle_boleta ON producto.sku = detalle_boleta.sku
GROUP BY producto.categoria_producto;

rollback;