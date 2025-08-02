#maxsulatlar
CREATE TABLE products (
                          id BIGINT PRIMARY KEY AUTO_INCREMENT,
                          name VARCHAR(255) NOT NULL,
                          description TEXT,
                          quantity INT NOT NULL DEFAULT 0,
                          price DECIMAL(10,2) NOT NULL,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

# categories
CREATE TABLE categories (
                            id BIGINT PRIMARY KEY AUTO_INCREMENT,
                            name VARCHAR(100) NOT NULL UNIQUE
);
# product-category
CREATE TABLE product_category (
                                  product_id BIGINT,
                                  category_id BIGINT,
                                  PRIMARY KEY (product_id, category_id),
                                  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
                                  FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);
#werehouses
CREATE TABLE warehouses (
                            id BIGINT PRIMARY KEY AUTO_INCREMENT,
                            name VARCHAR(255) NOT NULL,
                            location VARCHAR(255),
                            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
#product_stock (mahsulotning qaysi omborda qancha borligi)
CREATE TABLE product_stock (
                               id BIGINT PRIMARY KEY AUTO_INCREMENT,
                               product_id BIGINT NOT NULL,
                               warehouse_id BIGINT NOT NULL,
                               quantity INT NOT NULL DEFAULT 0,
                               FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
                               FOREIGN KEY (warehouse_id) REFERENCES warehouses(id) ON DELETE CASCADE,
                               UNIQUE (product_id, warehouse_id)
);
#transactions (kirim/chiqim harakatlari)
CREATE TABLE transactions (
                              id BIGINT PRIMARY KEY AUTO_INCREMENT,
                              product_id BIGINT NOT NULL,
                              warehouse_id BIGINT NOT NULL,
                              quantity INT NOT NULL,
                              transaction_type ENUM('IN', 'OUT') NOT NULL,
                              created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                              FOREIGN KEY (product_id) REFERENCES products(id),
                              FOREIGN KEY (warehouse_id) REFERENCES warehouses(id)
);
#
CREATE TABLE suppliers (
                           id BIGINT PRIMARY KEY AUTO_INCREMENT,
                           name VARCHAR(100) NOT NULL,
                           phone_number VARCHAR(20) UNIQUE
);
#
CREATE TABLE customers (
                           id BIGINT PRIMARY KEY AUTO_INCREMENT,
                           name VARCHAR(100) NOT NULL,
                           phone_number VARCHAR(20) UNIQUE
);
#
CREATE TABLE inputs (
                        id BIGINT PRIMARY KEY AUTO_INCREMENT,
                        date DATE NOT NULL,
                        warehouse_id BIGINT,
                        supplier_id BIGINT,
                        facture_number VARCHAR(50),
                        FOREIGN KEY (warehouse_id) REFERENCES warehouses(id)
                            ON DELETE SET NULL ON UPDATE CASCADE,
                        FOREIGN KEY (supplier_id) REFERENCES suppliers(id)
                            ON DELETE SET NULL ON UPDATE CASCADE
);
#
CREATE TABLE input_products (
                                id BIGINT PRIMARY KEY AUTO_INCREMENT,
                                input_id BIGINT,
                                product_id BIGINT,
                                amount DECIMAL(10,2) NOT NULL,
                                price DECIMAL(10,2) NOT NULL,
                                expire_date DATE,
                                FOREIGN KEY (input_id) REFERENCES inputs(id)
                                    ON DELETE CASCADE ON UPDATE CASCADE,
                                FOREIGN KEY (product_id) REFERENCES products(id)
                                    ON DELETE CASCADE ON UPDATE CASCADE
);
#
CREATE TABLE outputs (
                         id BIGINT PRIMARY KEY AUTO_INCREMENT,
                         date DATE NOT NULL,
                         warehouse_id BIGINT,
                         customer_id BIGINT,
                         facture_number VARCHAR(50),
                         FOREIGN KEY (warehouse_id) REFERENCES warehouses(id)
                             ON DELETE SET NULL ON UPDATE CASCADE,
                         FOREIGN KEY (customer_id) REFERENCES customers(id)
                             ON DELETE SET NULL ON UPDATE CASCADE
);
#
CREATE TABLE output_products (
                                 id BIGINT PRIMARY KEY AUTO_INCREMENT,
                                 output_id BIGINT,
                                 product_id BIGINT,
                                 amount DECIMAL(10,2) NOT NULL,
                                 price DECIMAL(10,2) NOT NULL,
                                 FOREIGN KEY (output_id) REFERENCES outputs(id)
                                     ON DELETE CASCADE ON UPDATE CASCADE,
                                 FOREIGN KEY (product_id) REFERENCES products(id)
                                     ON DELETE CASCADE ON UPDATE CASCADE
);





