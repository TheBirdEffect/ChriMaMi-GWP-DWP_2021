-- MySQL Script generated by MySQL Workbench
-- Fri Feb 19 15:59:51 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema HORSCH_DB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema HORSCH_DB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `HORSCH_DB` DEFAULT CHARACTER SET utf8 ;
USE `HORSCH_DB` ;

-- -----------------------------------------------------
-- Table `HORSCH_DB`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HORSCH_DB`.`addresses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(64) NOT NULL,
  `house_number` VARCHAR(10) NOT NULL,
  `city` VARCHAR(64) NOT NULL,
  `zip` VARCHAR(5) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HORSCH_DB`.`members`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HORSCH_DB`.`members` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `roll` VARCHAR(45) NOT NULL DEFAULT 'user',
  `firstname` VARCHAR(255) NOT NULL,
  `lastname` VARCHAR(255) NOT NULL,
  `gender` CHAR NOT NULL,
  `phone` VARCHAR(20) NULL,
  `addresses_id` INT NOT NULL,
  PRIMARY KEY (`id`, `addresses_id`, `email`),
  INDEX `fk_customers_addresses1_idx` (`addresses_id` ASC),
  CONSTRAINT `fk_customers_addresses1`
    FOREIGN KEY (`addresses_id`)
    REFERENCES `HORSCH_DB`.`addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HORSCH_DB`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HORSCH_DB`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(15) NOT NULL,
  `order_date` DATETIME NOT NULL,
  `invoice_addresses_id` INT NOT NULL,
  `delivery_addresses_id` INT NULL,
  `members_id` INT NOT NULL,
  INDEX `fk_orders_addresses1_idx` (`invoice_addresses_id` ASC),
  PRIMARY KEY (`id`, `invoice_addresses_id`, `members_id`),
  INDEX `fk_orders_addresses2_idx` (`delivery_addresses_id` ASC),
  INDEX `fk_orders_customers1_idx` (`members_id` ASC),
  CONSTRAINT `fk_orders_addresses1`
    FOREIGN KEY (`invoice_addresses_id`)
    REFERENCES `HORSCH_DB`.`addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_addresses2`
    FOREIGN KEY (`delivery_addresses_id`)
    REFERENCES `HORSCH_DB`.`addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`members_id`)
    REFERENCES `HORSCH_DB`.`members` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HORSCH_DB`.`images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HORSCH_DB`.`images` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `filename` VARCHAR(255) NOT NULL,
  `alt_text` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `filename_UNIQUE` (`filename` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HORSCH_DB`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HORSCH_DB`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HORSCH_DB`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HORSCH_DB`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `description` VARCHAR(2000) NOT NULL,
  `std_price` DECIMAL(10,2) NOT NULL,
  `images_id` INT NOT NULL,
  `categories_id` INT NOT NULL,
  PRIMARY KEY (`id`, `images_id`, `categories_id`),
  INDEX `fk_products_images1_idx` (`images_id` ASC),
  INDEX `fk_products_categories1_idx` (`categories_id` ASC),
  CONSTRAINT `fk_products_images1`
    FOREIGN KEY (`images_id`)
    REFERENCES `HORSCH_DB`.`images` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_categories1`
    FOREIGN KEY (`categories_id`)
    REFERENCES `HORSCH_DB`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	';


-- -----------------------------------------------------
-- Table `HORSCH_DB`.`orders_has_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HORSCH_DB`.`orders_has_products` (
  `orders_id` INT NOT NULL AUTO_INCREMENT,
  `products_id` INT NOT NULL,
  `amount` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`orders_id`, `products_id`),
  INDEX `fk_orders_has_products_products1_idx` (`products_id` ASC),
  INDEX `fk_orders_has_products_orders1_idx` (`orders_id` ASC),
  CONSTRAINT `fk_orders_has_products_orders1`
    FOREIGN KEY (`orders_id`)
    REFERENCES `HORSCH_DB`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_has_products_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `HORSCH_DB`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HORSCH_DB`.`member_has_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HORSCH_DB`.`member_has_products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `products_id` INT NOT NULL,
  `members_id` INT NOT NULL,
  `amount` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_carts_has_products1_products1_idx` (`products_id` ASC),
  INDEX `fk_customer_has_products_customers1_idx` (`members_id` ASC),
  CONSTRAINT `fk_carts_has_products1_products1`
    FOREIGN KEY (`products_id`)
    REFERENCES `HORSCH_DB`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_has_products_customers1`
    FOREIGN KEY (`members_id`)
    REFERENCES `HORSCH_DB`.`members` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `HORSCH_DB` ;

-- -----------------------------------------------------
-- Placeholder table for view `HORSCH_DB`.`products_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HORSCH_DB`.`products_view` (`id` INT, `name` INT, `description` INT, `category` INT, `std_price` INT, `filename` INT, `alt_text` INT);

-- -----------------------------------------------------
-- Placeholder table for view `HORSCH_DB`.`cart_view`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HORSCH_DB`.`cart_view` (`mem_id` INT, `filename` INT, `alt_text` INT, `p_name` INT, `std_price` INT, `total_price` INT, `amount` INT);

-- -----------------------------------------------------
-- View `HORSCH_DB`.`products_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HORSCH_DB`.`products_view`;
USE `HORSCH_DB`;
create  OR REPLACE view `products_view` as
select p.id, p.name, p.description, c.name as category,  p.std_price, i.filename, i.alt_text
from products p join images i on p.images_id = i.id join categories c on p.categories_id = c.id
order by name;

-- -----------------------------------------------------
-- View `HORSCH_DB`.`cart_view`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `HORSCH_DB`.`cart_view`;
USE `HORSCH_DB`;
create  OR REPLACE view `cart_view` as
select m.id as mem_id, i.filename, i.alt_text, p.name as p_name, p.std_price, p.std_price*mhp.amount as total_price, mhp.amount
from member_has_products mhp    join products p on mhp.products_id = p.id
                                join images i on p.images_id = i.id
                                join members m on mhp.members_id = m.id
order by name;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `HORSCH_DB`.`addresses`
-- -----------------------------------------------------
START TRANSACTION;
USE `HORSCH_DB`;
INSERT INTO `HORSCH_DB`.`addresses` (`id`, `street`, `house_number`, `city`, `zip`) VALUES (1, 'Musterstraße', '123', 'Musterdorf', '12345');
INSERT INTO `HORSCH_DB`.`addresses` (`id`, `street`, `house_number`, `city`, `zip`) VALUES (2, 'Hauptstraße', '2c', 'Hauptstadt', '54321');
INSERT INTO `HORSCH_DB`.`addresses` (`id`, `street`, `house_number`, `city`, `zip`) VALUES (3, 'Altonaerstraße', '25', 'Erfurt', '99086');
INSERT INTO `HORSCH_DB`.`addresses` (`id`, `street`, `house_number`, `city`, `zip`) VALUES (4, 'Alfred-Wber-Platz', '2', 'Erfurt', '99089');
INSERT INTO `HORSCH_DB`.`addresses` (`id`, `street`, `house_number`, `city`, `zip`) VALUES (5, 'Leipziger Straße', '77', 'Erfurt', '99085');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HORSCH_DB`.`members`
-- -----------------------------------------------------
START TRANSACTION;
USE `HORSCH_DB`;
INSERT INTO `HORSCH_DB`.`members` (`id`, `email`, `password_hash`, `roll`, `firstname`, `lastname`, `gender`, `phone`, `addresses_id`) VALUES (1, 'matthias.gabel@fh-erfurt.de', '$2y$10$NDtr5aL6cs4/9ahZpGRlyeQYqlNx.VYNCoJQeO2Dm0nYe9wIs1kmK', 'admin', 'Matthias', 'Gabel', 'm', '01234-987652', 1);
INSERT INTO `HORSCH_DB`.`members` (`id`, `email`, `password_hash`, `roll`, `firstname`, `lastname`, `gender`, `phone`, `addresses_id`) VALUES (2, 'mickey.knop@fh-erfurt.de', '$2y$10$NDtr5aL6cs4/9ahZpGRlyeQYqlNx.VYNCoJQeO2Dm0nYe9wIs1kmK', 'admin', 'Mickey', 'Knop', 'm', '01236-456892', 1);
INSERT INTO `HORSCH_DB`.`members` (`id`, `email`, `password_hash`, `roll`, `firstname`, `lastname`, `gender`, `phone`, `addresses_id`) VALUES (3, 'christoph.frischmuth@fh-erfurt.de', '$2y$10$NDtr5aL6cs4/9ahZpGRlyeQYqlNx.VYNCoJQeO2Dm0nYe9wIs1kmK', 'amdin', 'Christoph', 'Frischmuth', 'm', '05498-654132', 1);
INSERT INTO `HORSCH_DB`.`members` (`id`, `email`, `password_hash`, `roll`, `firstname`, `lastname`, `gender`, `phone`, `addresses_id`) VALUES (4, 'kristof.friess@fh-erfurt.de', '$2y$10$qWPrhugFkBT2te.IrCQQO.SzLoRXVI5bC1S.dwM6Cqfjs8F.x7k9W', 'user', 'Kristof', 'Friess', 'm', '01337-567890', 2);
INSERT INTO `HORSCH_DB`.`members` (`id`, `email`, `password_hash`, `roll`, `firstname`, `lastname`, `gender`, `phone`, `addresses_id`) VALUES (5, 'saskia.wohlers@fh-erfurt.de', '$2y$10$qWPrhugFkBT2te.IrCQQO.SzLoRXVI5bC1S.dwM6Cqfjs8F.x7k9W', 'user', 'Saskia', 'Wohlers', 'w', '01234-098765', 2);
INSERT INTO `HORSCH_DB`.`members` (`id`, `email`, `password_hash`, `roll`, `firstname`, `lastname`, `gender`, `phone`, `addresses_id`) VALUES (6, 'dirk.hofmann@fh-erfurt.de', '$2y$10$qWPrhugFkBT2te.IrCQQO.SzLoRXVI5bC1S.dwM6Cqfjs8F.x7k9W', 'user', 'Dirk', 'Hofmann', 'm', '04321-567890', 2);
INSERT INTO `HORSCH_DB`.`members` (`id`, `email`, `password_hash`, `roll`, `firstname`, `lastname`, `gender`, `phone`, `addresses_id`) VALUES (7, 'luca.voge@fh-erfurt.de', '$2y$10$qWPrhugFkBT2te.IrCQQO.SzLoRXVI5bC1S.dwM6Cqfjs8F.x7k9W', 'user', 'Luca', 'Voges', 'm', '01337-543210', 5);
INSERT INTO `HORSCH_DB`.`members` (`id`, `email`, `password_hash`, `roll`, `firstname`, `lastname`, `gender`, `phone`, `addresses_id`) VALUES (8, 'keck@gmail.de', '$2y$10$qWPrhugFkBT2te.IrCQQO.SzLoRXVI5bC1S.dwM6Cqfjs8F.x7k9W', 'user', 'Karl-Erik', 'Cley', 'm', '01337-383175', 3);
INSERT INTO `HORSCH_DB`.`members` (`id`, `email`, `password_hash`, `roll`, `firstname`, `lastname`, `gender`, `phone`, `addresses_id`) VALUES (9, 'hannes.droese@fh-erfurt.de', '$2y$10$qWPrhugFkBT2te.IrCQQO.SzLoRXVI5bC1S.dwM6Cqfjs8F.x7k9W', 'user', 'Hannes', 'Dröse', 'm', '01337-598756', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HORSCH_DB`.`orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `HORSCH_DB`;
INSERT INTO `HORSCH_DB`.`orders` (`id`, `status`, `order_date`, `invoice_addresses_id`, `delivery_addresses_id`, `members_id`) VALUES (1, 'Bestellung eingegangen', '2021-01-15 15:00:15.000000', 1, 2, 1);
INSERT INTO `HORSCH_DB`.`orders` (`id`, `status`, `order_date`, `invoice_addresses_id`, `delivery_addresses_id`, `members_id`) VALUES (2, 'Bestellung in Bearbeitung', '2021-02-16 16:15:03.000000', 2, 1, 2);
INSERT INTO `HORSCH_DB`.`orders` (`id`, `status`, `order_date`, `invoice_addresses_id`, `delivery_addresses_id`, `members_id`) VALUES (3, 'Bestellung wird geliefert', '2021-03-17 17:30:04.000000', 3, 2, 3);
INSERT INTO `HORSCH_DB`.`orders` (`id`, `status`, `order_date`, `invoice_addresses_id`, `delivery_addresses_id`, `members_id`) VALUES (4, 'Bestellung ist abgeschlossen', '2021-04-18 18:45:20.000000', 4, 3, 4);
INSERT INTO `HORSCH_DB`.`orders` (`id`, `status`, `order_date`, `invoice_addresses_id`, `delivery_addresses_id`, `members_id`) VALUES (5, 'Bestellung in Bearbeitung', '2021-05-19 19:59:30.000000', 5, 3, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HORSCH_DB`.`images`
-- -----------------------------------------------------
START TRANSACTION;
USE `HORSCH_DB`;
INSERT INTO `HORSCH_DB`.`images` (`id`, `filename`, `alt_text`) VALUES (1, 'item1.jpg', 'fehlt noch in der DB 1');
INSERT INTO `HORSCH_DB`.`images` (`id`, `filename`, `alt_text`) VALUES (2, 'item2.jpg', 'fehlt noch in der DB 2');
INSERT INTO `HORSCH_DB`.`images` (`id`, `filename`, `alt_text`) VALUES (3, 'item3.jpg', 'fehlt noch in der DB 3');
INSERT INTO `HORSCH_DB`.`images` (`id`, `filename`, `alt_text`) VALUES (4, 'item4.jpg', 'fehlt noch in der DB 4');
INSERT INTO `HORSCH_DB`.`images` (`id`, `filename`, `alt_text`) VALUES (5, 'item5.jpg', 'fehlt noch in der DB 5');
INSERT INTO `HORSCH_DB`.`images` (`id`, `filename`, `alt_text`) VALUES (6, 'item6.jpg', 'fehlt noch in der DB 6');
INSERT INTO `HORSCH_DB`.`images` (`id`, `filename`, `alt_text`) VALUES (7, 'item7.jpg', 'fehlt noch in der DB 7');
INSERT INTO `HORSCH_DB`.`images` (`id`, `filename`, `alt_text`) VALUES (8, 'item8.jpg', 'fehlt noch in der DB 8');
INSERT INTO `HORSCH_DB`.`images` (`id`, `filename`, `alt_text`) VALUES (9, 'item9.jpg', 'fehlt noch in der DB 9');
INSERT INTO `HORSCH_DB`.`images` (`id`, `filename`, `alt_text`) VALUES (10, 'item10.jpg', 'fehlt noch in der DB 10');
INSERT INTO `HORSCH_DB`.`images` (`id`, `filename`, `alt_text`) VALUES (11, 'item11.jpg', 'fehlt noch in der DB 11');
INSERT INTO `HORSCH_DB`.`images` (`id`, `filename`, `alt_text`) VALUES (12, 'item12.jpg', 'fehlt noch in der DB 12');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HORSCH_DB`.`categories`
-- -----------------------------------------------------
START TRANSACTION;
USE `HORSCH_DB`;
INSERT INTO `HORSCH_DB`.`categories` (`id`, `name`) VALUES (1, 'fire_protection');
INSERT INTO `HORSCH_DB`.`categories` (`id`, `name`) VALUES (2, 'heat_protection');
INSERT INTO `HORSCH_DB`.`categories` (`id`, `name`) VALUES (3, 'structural_planning');
INSERT INTO `HORSCH_DB`.`categories` (`id`, `name`) VALUES (4, 'input_planning');

COMMIT;


-- -----------------------------------------------------
-- Data for table `HORSCH_DB`.`products`
-- -----------------------------------------------------
START TRANSACTION;
USE `HORSCH_DB`;
INSERT INTO `HORSCH_DB`.`products` (`id`, `name`, `description`, `std_price`, `images_id`, `categories_id`) VALUES (1, 'Item 1', 'Beschreibung Item 1 \"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,\"', 1000, 1, 2);
INSERT INTO `HORSCH_DB`.`products` (`id`, `name`, `description`, `std_price`, `images_id`, `categories_id`) VALUES (2, 'Item 2', 'Beschreibung Item 2 \"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,\"', 2000, 2, 4);
INSERT INTO `HORSCH_DB`.`products` (`id`, `name`, `description`, `std_price`, `images_id`, `categories_id`) VALUES (3, 'Item 3', 'Beschreibung Item 3  \"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,\"', 1050, 3, 3);
INSERT INTO `HORSCH_DB`.`products` (`id`, `name`, `description`, `std_price`, `images_id`, `categories_id`) VALUES (4, 'Item 4', 'Beschreibung Item 4 \"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,\"', 1500, 4, 2);
INSERT INTO `HORSCH_DB`.`products` (`id`, `name`, `description`, `std_price`, `images_id`, `categories_id`) VALUES (5, 'Item 5', 'Beschreibung Item 5 \"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,\"', 2200, 5, 4);
INSERT INTO `HORSCH_DB`.`products` (`id`, `name`, `description`, `std_price`, `images_id`, `categories_id`) VALUES (6, 'Item 6', 'Beschreibung Item 6 \"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,\"', 1300, 6, 1);
INSERT INTO `HORSCH_DB`.`products` (`id`, `name`, `description`, `std_price`, `images_id`, `categories_id`) VALUES (7, 'Item 7', 'Beschreibung Item 7 \"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,\"', 500, 7, 1);
INSERT INTO `HORSCH_DB`.`products` (`id`, `name`, `description`, `std_price`, `images_id`, `categories_id`) VALUES (8, 'Item 8', 'Beschreibung Item 8 \"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,\"', 1999, 8, 2);
INSERT INTO `HORSCH_DB`.`products` (`id`, `name`, `description`, `std_price`, `images_id`, `categories_id`) VALUES (9, 'Item 9', 'Beschreibung Item 9 \"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,\"', 1756, 9, 2);
INSERT INTO `HORSCH_DB`.`products` (`id`, `name`, `description`, `std_price`, `images_id`, `categories_id`) VALUES (10, 'Item 10', 'Beschreibung Item 10 \"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,\"', 1354, 10, 4);
INSERT INTO `HORSCH_DB`.`products` (`id`, `name`, `description`, `std_price`, `images_id`, `categories_id`) VALUES (11, 'Item 11', 'Beschreibung Item 11 \"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,\"', 1975, 11, 4);
INSERT INTO `HORSCH_DB`.`products` (`id`, `name`, `description`, `std_price`, `images_id`, `categories_id`) VALUES (12, 'Item 12', 'Beschreibung Item 12 \"Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,\"', 645, 12, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `HORSCH_DB`.`orders_has_products`
-- -----------------------------------------------------
START TRANSACTION;
USE `HORSCH_DB`;
INSERT INTO `HORSCH_DB`.`orders_has_products` (`orders_id`, `products_id`, `amount`, `price`) VALUES (1, 2, 1, 1000);
INSERT INTO `HORSCH_DB`.`orders_has_products` (`orders_id`, `products_id`, `amount`, `price`) VALUES (2, 4, 1, 1200);
INSERT INTO `HORSCH_DB`.`orders_has_products` (`orders_id`, `products_id`, `amount`, `price`) VALUES (3, 3, 2, 3000);
INSERT INTO `HORSCH_DB`.`orders_has_products` (`orders_id`, `products_id`, `amount`, `price`) VALUES (4, 5, 1, 2500);
INSERT INTO `HORSCH_DB`.`orders_has_products` (`orders_id`, `products_id`, `amount`, `price`) VALUES (5, 2, 1, 2000);

COMMIT;

