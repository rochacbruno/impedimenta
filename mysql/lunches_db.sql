-- ************************************************************
-- LUNCHES DATABASE TABLES:
--     l_employees
--     l_foods
--     l_departments
--     l_lunches
--     l_lunch_items
--     l_suppliers
--     l_constants
-- ************************************************************

DROP DATABASE lunches;
CREATE DATABASE lunches;
USE lunches;

CREATE TABLE l_employees
(
    employee_id     INT(3) PRIMARY KEY AUTO_INCREMENT,
    first_name      VARCHAR(10) NOT NULL,
    last_name       VARCHAR(20) NOT NULL,
    dept_code       VARCHAR(3),
    hire_date       DATE,
    credit_limit    DECIMAL(4,2),
    phone_number    VARCHAR(4),
    manager_id      INT(3)
) ENGINE=InnoDB;
ALTER TABLE l_employees AUTO_INCREMENT = 201;

INSERT INTO l_employees VALUES
  (NULL, 'SUSAN', 'BROWN', 'EXE', STR_TO_DATE('01-06-1998', '%d-%m-%Y'), 30, '3484', NULL);
INSERT INTO l_employees VALUES
  (NULL, 'JIM', 'KERN', 'SAL', STR_TO_DATE('16-08-1999', '%d-%m-%Y'), 25, '8722', 201);
INSERT INTO l_employees VALUES
  (NULL, 'MARTHA', 'WOODS', 'SHP', STR_TO_DATE('02-02-2009', '%d-%m-%Y'), 25, '7591', 201);
INSERT INTO l_employees VALUES
  (NULL, 'ELLEN', 'OWENS', 'SAL', STR_TO_DATE('01-07-2008', '%d-%m-%Y'), 15, '6830', 202);
INSERT INTO l_employees VALUES
  (NULL, 'HENRY', 'PERKINS', 'SAL', STR_TO_DATE('01-03-2006', '%d-%m-%Y'), 25, '5286', 202);
INSERT INTO l_employees VALUES
  (NULL, 'CAROL', 'ROSE', 'ACT', NULL, NULL, NULL, NULL);
INSERT INTO l_employees VALUES
  (NULL, 'DAN', 'SMITH', 'SHP', STR_TO_DATE('01-12-2008', '%d-%m-%Y'), 25, '2259', 203);
INSERT INTO l_employees VALUES
  (NULL, 'FRED', 'CAMPBELL', 'SHP', STR_TO_DATE('01-04-2008', '%d-%m-%Y'), 25, '1752', 203);
INSERT INTO l_employees VALUES
  (NULL, 'PAULA', 'JACOBS', 'MKT', STR_TO_DATE('17-03-1999', '%d-%m-%Y'), 15, '3357', 201);
INSERT INTO l_employees VALUES
  (NULL, 'NANCY', 'HOFFMAN', 'SAL', STR_TO_DATE('16-02-2007', '%d-%m-%Y'), 25, '2974', 203);
COMMIT;

-- *************************************

CREATE TABLE l_foods
(
    supplier_id     VARCHAR(3),
    product_code    VARCHAR(2),
    menu_item       DECIMAL(2),
    description     VARCHAR(20),
    price           DECIMAL(4,2),
    price_increase  DECIMAL(4,2),
    PRIMARY KEY (supplier_id, product_code)
) ENGINE=InnoDB;

INSERT INTO l_foods VALUES ('ASP', 'FS', 1, 'FRESH SALAD', 2, 0.25);
INSERT INTO l_foods VALUES ('ASP', 'SP', 2, 'SOUP OF THE DAY', 1.5, NULL);
INSERT INTO l_foods VALUES ('ASP', 'SW', 3, 'SANDWICH', 3.5, 0.4);
INSERT INTO l_foods VALUES ('CBC', 'GS', 4, 'GRILLED STEAK', 6, 0.7);
INSERT INTO l_foods VALUES ('CBC', 'SW', 5, 'HAMBURGER', 2.5, 0.3);
INSERT INTO l_foods VALUES ('FRV', 'BR', 7, 'BROCCOLI', 1, 0.05);
INSERT INTO l_foods VALUES ('FRV', 'FF', 7, 'FRENCH FRIES', 1.5, NULL);
INSERT INTO l_foods VALUES ('JBR', 'AS', 8, 'SODA', 1.25, 0.25);
INSERT INTO l_foods VALUES ('JBR', 'VR', 9, 'COFFEE', 0.85, 0.15);
INSERT INTO l_foods VALUES ('VSB', 'AS', 10, 'DESSERT', 3, 0.5);
COMMIT;

-- *************************************

CREATE TABLE l_departments
(
    dept_code           VARCHAR(3) PRIMARY KEY,
    department_name     VARCHAR(30)
) ENGINE=InnoDB;

INSERT INTO l_departments VALUES ('ACT', 'ACCOUNTING');
INSERT INTO l_departments VALUES ('EXE', 'EXECUTIVE');
INSERT INTO l_departments VALUES ('MKT', 'MARKETING');
INSERT INTO l_departments VALUES ('PER', 'PERSONNEL');
INSERT INTO l_departments VALUES ('SAL', 'SALES');
INSERT INTO l_departments VALUES ('SHP', 'SHIPPING');
COMMIT;

-- *************************************

CREATE TABLE l_lunches
(
    lunch_id      DECIMAL(3) PRIMARY KEY,
    lunch_date    DATE,
    employee_id   INT(3),
    date_entered  DATETIME
) ENGINE=InnoDB;

INSERT INTO l_lunches VALUES (1, STR_TO_DATE('16-11-2011', '%d-%m-%Y'), 201, STR_TO_DATE('13-10-2011 10:35:24', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (2, STR_TO_DATE('16-11-2011', '%d-%m-%Y'), 207, STR_TO_DATE('13-10-2011 10:35:39', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (3, STR_TO_DATE('16-11-2011', '%d-%m-%Y'), 203, STR_TO_DATE('13-10-2011 10:35:45', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (4, STR_TO_DATE('16-11-2011', '%d-%m-%Y'), 204, STR_TO_DATE('13-10-2011 10:35:58', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (6, STR_TO_DATE('16-11-2011', '%d-%m-%Y'), 202, STR_TO_DATE('13-10-2011 10:36:41', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (7, STR_TO_DATE('16-11-2011', '%d-%m-%Y'), 210, STR_TO_DATE('13-10-2011 10:38:52', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (8, STR_TO_DATE('25-11-2011', '%d-%m-%Y'), 201, STR_TO_DATE('14-10-2011 11:15:37', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (9, STR_TO_DATE('25-11-2011', '%d-%m-%Y'), 208, STR_TO_DATE('14-10-2011 14:23:36', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (12, STR_TO_DATE('25-11-2011', '%d-%m-%Y'), 204, STR_TO_DATE('14-10-2011 15:02:53', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (13, STR_TO_DATE('25-11-2011', '%d-%m-%Y'), 207, STR_TO_DATE('18-10-2011 08:42:11', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (15, STR_TO_DATE('25-11-2011', '%d-%m-%Y'), 205, STR_TO_DATE('21-10-2011 16:23:50', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (16, STR_TO_DATE('05-12-2011', '%d-%m-%Y'), 201, STR_TO_DATE('21-10-2011 16:23:59', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (17, STR_TO_DATE('05-12-2011', '%d-%m-%Y'), 210, STR_TO_DATE('21-10-2011 16:35:26', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (20, STR_TO_DATE('05-12-2011', '%d-%m-%Y'), 205, STR_TO_DATE('24-10-2011 09:55:27', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (21, STR_TO_DATE('05-12-2011', '%d-%m-%Y'), 203, STR_TO_DATE('24-10-2011 11:43:13', '%d-%m-%Y %H:%i:%s'));
INSERT INTO l_lunches VALUES (22, STR_TO_DATE('05-12-2011', '%d-%m-%Y'), 208, STR_TO_DATE('24-10-2011 14:37:32', '%d-%m-%Y %H:%i:%s'));
COMMIT;

-- *************************************

CREATE TABLE l_lunch_items
(
    lunch_id        DECIMAL(3),
    item_number     DECIMAL(2),
    supplier_id     VARCHAR(3),
    product_code    VARCHAR(2),
    quantity        DECIMAL(1),
    PRIMARY KEY     (lunch_id, item_number)
) ENGINE=InnoDB;

INSERT INTO l_lunch_items VALUES (1, 1, 'ASP', 'FS', 1);
INSERT INTO l_lunch_items VALUES (1, 2, 'ASP', 'SW', 2);
INSERT INTO l_lunch_items VALUES (1, 3, 'JBR', 'VR', 2);
INSERT INTO l_lunch_items VALUES (2, 1, 'ASP', 'SW', 2);
INSERT INTO l_lunch_items VALUES (2, 2, 'FRV', 'FF', 1);
INSERT INTO l_lunch_items VALUES (2, 3, 'JBR', 'VR', 2);
INSERT INTO l_lunch_items VALUES (2, 4, 'VSB', 'AS', 1);
INSERT INTO l_lunch_items VALUES (3, 1, 'ASP', 'FS', 1);
INSERT INTO l_lunch_items VALUES (3, 2, 'CBC', 'GS', 1);
INSERT INTO l_lunch_items VALUES (3, 3, 'FRV', 'FF', 1);
INSERT INTO l_lunch_items VALUES (3, 4, 'JBR', 'VR', 1);
INSERT INTO l_lunch_items VALUES (3, 5, 'JBR', 'AS', 1);
INSERT INTO l_lunch_items VALUES (4, 1, 'ASP', 'SP', 2);
INSERT INTO l_lunch_items VALUES (4, 2, 'CBC', 'SW', 2);
INSERT INTO l_lunch_items VALUES (4, 3, 'FRV', 'FF', 1);
INSERT INTO l_lunch_items VALUES (4, 4, 'JBR', 'AS', 2);
INSERT INTO l_lunch_items VALUES (6, 1, 'ASP', 'SP', 1);
INSERT INTO l_lunch_items VALUES (6, 2, 'CBC', 'GS', 1);
INSERT INTO l_lunch_items VALUES (6, 3, 'FRV', 'FF', 1);
INSERT INTO l_lunch_items VALUES (6, 4, 'JBR', 'VR', 2);
INSERT INTO l_lunch_items VALUES (6, 5, 'VSB', 'AS', 1);
INSERT INTO l_lunch_items VALUES (7, 1, 'ASP', 'FS', 1);
INSERT INTO l_lunch_items VALUES (7, 2, 'ASP', 'SP', 1);
INSERT INTO l_lunch_items VALUES (7, 3, 'CBC', 'GS', 1);
INSERT INTO l_lunch_items VALUES (7, 4, 'JBR', 'VR', 1);
INSERT INTO l_lunch_items VALUES (7, 5, 'VSB', 'AS', 1);
INSERT INTO l_lunch_items VALUES (8, 1, 'ASP', 'FS', 1);
INSERT INTO l_lunch_items VALUES (8, 2, 'CBC', 'GS', 1);
INSERT INTO l_lunch_items VALUES (8, 3, 'JBR', 'AS', 1);
INSERT INTO l_lunch_items VALUES (9, 1, 'ASP', 'FS', 1);
INSERT INTO l_lunch_items VALUES (9, 2, 'ASP', 'SP', 1);
INSERT INTO l_lunch_items VALUES (9, 3, 'CBC', 'SW', 2);
INSERT INTO l_lunch_items VALUES (9, 4, 'FRV', 'FF', 1);
INSERT INTO l_lunch_items VALUES (9, 5, 'JBR', 'VR', 1);
INSERT INTO l_lunch_items VALUES (9, 6, 'JBR', 'AS', 1);
INSERT INTO l_lunch_items VALUES (12, 1, 'ASP', 'FS', 1);
INSERT INTO l_lunch_items VALUES (12, 2, 'CBC', 'GS', 1);
INSERT INTO l_lunch_items VALUES (12, 3, 'JBR', 'VR', 2);
INSERT INTO l_lunch_items VALUES (12, 4, 'VSB', 'AS', 1);
INSERT INTO l_lunch_items VALUES (13, 1, 'ASP', 'SP', 2);
INSERT INTO l_lunch_items VALUES (13, 2, 'ASP', 'SW', 2);
INSERT INTO l_lunch_items VALUES (13, 3, 'FRV', 'FF', 1);
INSERT INTO l_lunch_items VALUES (13, 4, 'JBR', 'AS', 1);
INSERT INTO l_lunch_items VALUES (15, 1, 'ASP', 'SP', 1);
INSERT INTO l_lunch_items VALUES (15, 2, 'CBC', 'GS', 1);
INSERT INTO l_lunch_items VALUES (15, 3, 'FRV', 'FF', 1);
INSERT INTO l_lunch_items VALUES (15, 4, 'JBR', 'AS', 2);
INSERT INTO l_lunch_items VALUES (16, 1, 'ASP', 'FS', 1);
INSERT INTO l_lunch_items VALUES (16, 2, 'ASP', 'SW', 1);
INSERT INTO l_lunch_items VALUES (16, 3, 'CBC', 'SW', 1);
INSERT INTO l_lunch_items VALUES (16, 4, 'JBR', 'VR', 1);
INSERT INTO l_lunch_items VALUES (16, 5, 'JBR', 'AS', 1);
INSERT INTO l_lunch_items VALUES (17, 1, 'ASP', 'SP', 1);
INSERT INTO l_lunch_items VALUES (17, 2, 'CBC', 'GS', 1);
INSERT INTO l_lunch_items VALUES (17, 3, 'FRV', 'FF', 1);
INSERT INTO l_lunch_items VALUES (17, 4, 'JBR', 'VR', 2);
INSERT INTO l_lunch_items VALUES (17, 5, 'VSB', 'AS', 1);
INSERT INTO l_lunch_items VALUES (20, 1, 'ASP', 'FS', 1);
INSERT INTO l_lunch_items VALUES (20, 2, 'ASP', 'SP', 1);
INSERT INTO l_lunch_items VALUES (20, 3, 'CBC', 'GS', 1);
INSERT INTO l_lunch_items VALUES (20, 4, 'FRV', 'FF', 1);
INSERT INTO l_lunch_items VALUES (20, 5, 'JBR', 'AS', 1);
INSERT INTO l_lunch_items VALUES (21, 1, 'ASP', 'SP', 1);
INSERT INTO l_lunch_items VALUES (21, 2, 'CBC', 'GS', 1);
INSERT INTO l_lunch_items VALUES (21, 3, 'JBR', 'VR', 2);
INSERT INTO l_lunch_items VALUES (21, 4, 'VSB', 'AS', 1);
INSERT INTO l_lunch_items VALUES (22, 1, 'ASP', 'FS', 1);
INSERT INTO l_lunch_items VALUES (22, 2, 'CBC', 'GS', 1);
INSERT INTO l_lunch_items VALUES (22, 3, 'FRV', 'FF', 1);
INSERT INTO l_lunch_items VALUES (22, 4, 'JBR', 'VR', 1);
INSERT INTO l_lunch_items VALUES (22, 5, 'JBR', 'AS', 1);
COMMIT;

-- *************************************

CREATE TABLE l_suppliers
(
    supplier_id      VARCHAR(3) PRIMARY KEY,
    supplier_name    VARCHAR(30)
) ENGINE=InnoDB;

INSERT INTO l_suppliers VALUES ('ARR', 'ALICE & RAY''S RESTAURANT');
INSERT INTO l_suppliers VALUES ('ASP', 'A SOUP PLACE');
INSERT INTO l_suppliers VALUES ('CBC', 'CERTIFIED BEEF COMPANY');
INSERT INTO l_suppliers VALUES ('FRV', 'FRANK REED''S VEGETABLES');
INSERT INTO l_suppliers VALUES ('FSN', 'FRANK & SONS');
INSERT INTO l_suppliers VALUES ('JBR', 'JUST BEVERAGES');
INSERT INTO l_suppliers VALUES ('JPS', 'JIM PARKER''S SHOP');
INSERT INTO l_suppliers VALUES ('VSB', 'VIRGINIA STREET BAKERY');
COMMIT;

-- *************************************

CREATE TABLE l_constants
(
    business_name          VARCHAR(30),
    business_start_date    DATE,
    lunch_budget           DECIMAL(5,2),
    owner_name             VARCHAR(30)
) ENGINE=InnoDB;

INSERT INTO l_constants VALUES
    ('CITYWIDE UNIFORMS', STR_TO_DATE('01-06-1998', '%d-%m-%Y'), 200, 'SUSAN BROWN');

COMMIT;

-- *************************************

-- Create Referential Integrity Constraints for the Lunches Database
ALTER TABLE l_employees
    ADD CONSTRAINT fk_l_employees_dept_code
    FOREIGN KEY (dept_code)
    REFERENCES l_departments (dept_code);

ALTER TABLE l_employees
    ADD CONSTRAINT fk_l_employees_manager_id
    FOREIGN KEY (manager_id)
    REFERENCES l_employees (employee_id);

ALTER TABLE l_lunches
    ADD CONSTRAINT fk_l_lunches_employees
    FOREIGN KEY (employee_id)
    REFERENCES l_employees (employee_id);

ALTER TABLE l_lunch_items
    ADD CONSTRAINT fk_l_lunch_items_lunches
    FOREIGN KEY (lunch_id)
    REFERENCES l_lunches (lunch_id);

ALTER TABLE l_lunch_items
    ADD CONSTRAINT fk_l_lunch_items_foods
    FOREIGN KEY (supplier_id, product_code)
    REFERENCES l_foods (supplier_id, product_code);

ALTER TABLE l_foods
ADD CONSTRAINT fk_l_foods_suppliers
    FOREIGN KEY (supplier_id)
    REFERENCES l_suppliers (supplier_id)
    ON DELETE CASCADE;

-- Create UNIQUENESS constraints
ALTER TABLE l_employees
ADD CONSTRAINT unique_l_employees_full_name
   UNIQUE (first_name, last_name);

ALTER TABLE l_employees
ADD CONSTRAINT unique_l_empployees_phone_num
   UNIQUE (phone_number);

-- Create CHECK constraints
ALTER TABLE l_foods
    ADD CONSTRAINT check_l_foods_price_max_price
    CHECK (price < 10.00);
