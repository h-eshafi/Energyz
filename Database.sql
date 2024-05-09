    DROP TABLE IF EXISTS `admins`;
    CREATE TABLE `admins` (
        `id` int unsigned NOT NULL AUTO_INCREMENT,
        `first_name` varchar(191)  DEFAULT NULL,
        `last_name` varchar(191)  DEFAULT NULL,
        `username` varchar(191)  DEFAULT NULL,
        `email` varchar(191)  NOT NULL,
        `password` varchar(191)  NOT NULL,
        `image` varchar(191)  DEFAULT NULL,
        `phone` varchar(191)  DEFAULT NULL,
        `address` text ,
        `created_at` timestamp NULL DEFAULT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `admins_email_unique` (`email`),
        UNIQUE KEY `admins_username_unique` (`username`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

    LOCK TABLES `admins` WRITE;
    /*!40000 ALTER TABLE `admins` DISABLE KEYS */;
    INSERT INTO `admins` (`id`, `first_name`, `last_name`,`username`, `email`, `password`, `image`, `phone`, `address`, `created_at`)
    VALUES
        (1,'admin','adminLast', 'adminUsername', 'admifn@gmail.com','example@Password.Energyz','63134ebae203c1662209722.jpg','123456789','london','2021-03-08 12:58:38');
    /*!40000 ALTER TABLE `admins` ENABLE KEYS */;
    UNLOCK TABLES;

    DROP TABLE IF EXISTS `users`;
    CREATE TABLE `users` (
        `id` int unsigned NOT NULL AUTO_INCREMENT,
        `firstname` varchar(191)  DEFAULT NULL,
        `lastname` varchar(191)  DEFAULT NULL,
        `username` varchar(191)  DEFAULT NULL,
        `email` varchar(191)  NOT NULL,
        `phone_code` varchar(15)  DEFAULT NULL,
        `phone` varchar(255)  DEFAULT NULL,
        `balance` decimal(11,2) NOT NULL DEFAULT '0.00',
        `image` varchar(191)  DEFAULT NULL,
        `address` text ,
        `status` tinyint(1) NOT NULL DEFAULT '1',
        `email_verification` tinyint(1) NOT NULL DEFAULT '0',
        `last_login` timestamp NULL DEFAULT NULL,
        `password` varchar(191)  NOT NULL,
        `email_verified_at` timestamp NULL DEFAULT NULL,
        `created_at` timestamp NULL DEFAULT NULL,
        `updated_at` timestamp NULL DEFAULT NULL,
        PRIMARY KEY (`id`),
        UNIQUE KEY `users_email_unique` (`email`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

    CREATE TABLE `posts` (
        `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        `title` VARCHAR(255) NOT NULL,
        `content` TEXT NOT NULL,
        `author_id` INT UNSIGNED,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (`author_id`) REFERENCES `users`(`id`)
    );

    CREATE TABLE comments (
        `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        `post_id` INT UNSIGNED,
        `user_id` INT UNSIGNED,
        `content` TEXT NOT NULL,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (`post_id`) REFERENCES posts(`id`),
        FOREIGN KEY (`user_id`) REFERENCES users(`id`)
    );

    CREATE TABLE newletter_emails (
        `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        `first_name` VARCHAR(50) NOT NULL,
        `email` VARCHAR(100) NOT NULL UNIQUE,
        `subscribed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

    CREATE TABLE general_data (
        `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        `department_code` INT UNSIGNED NOT NULL,
        `construction_year` ENUM(
            'Avant 1975',
            'de 1975 à 1977',
            'de 1978 à 1982',
            'de 1983 à 1988',
            'de 1989 à 2000',
            'de 2001 à 2005',
            'de 2005 à 2012',
            'à partir de 2012'
        ) NOT NULL,
        `housing_shape` ENUM(
            'Carré',
            'Rectangulaire',
            'Forme en L',
            'Forme en U'
        ) NOT NULL,
        `house_attached` ENUM(
            'Mitoyenne sur 2 côtés',
            'Mitoyenne sur un côté',
            'Indépendante (4 façades)'
        ) NOT NULL,
        `habitable_levels` ENUM(
            '1 niveau (rez)',
            '2 niveaux (rez+1)',
            '3 niveaux ou + (rez+2 ou plus)'
        ) NOT NULL,
        `living_area` VARCHAR(255) NOT NULL
    );

    CREATE TABLE wall_insulation (
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        is_insulated ENUM('Oui', 'Non') NOT NULL,
        insulation_range ENUM(
            'Avant 1975',
            'de 1975 à 1977',
            'de 1978 à 1982',
            'de 1983 à 1988',
            'de 1989 à 2000',
            'de 2001 à 2005',
            'de 2005 à 2012',
            'à partir de 2012'
        ),
        FOREIGN KEY (user_id) REFERENCES users(id),
        PRIMARY KEY (user_id)
    );

    CREATE TABLE floor_insulation (
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        floor_type ENUM(
            'Sur vide sanitaire ou sous-sol',
            'Sur terre-plein'
        ) NOT NULL,
        is_insulated ENUM('Oui', 'Non') NOT NULL,
        insulation_range ENUM(
            'Avant 1975',
            'de 1975 à 1977',
            'de 1978 à 1982',
            'de 1983 à 1988',
            'de 1989 à 2000',
            'de 2001 à 2005',
            'de 2005 à 2012',
            'à partir de 2012'
        ),
        FOREIGN KEY (user_id) REFERENCES users(id),
        PRIMARY KEY (user_id)
    );

    CREATE TABLE upper_floor_insulation (
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        nature ENUM(
            'Combles perdus (combles)',
            'Combles aménagés (combles)',
            'Toiture terrasse'
        ),
        is_insulated ENUM('Oui', 'Non') NOT NULL,
        insulation_range ENUM(
            'Avant 1975',
            'de 1975 à 1977',
            'de 1978 à 1982',
            'de 1983 à 1988',
            'de 1989 à 2000',
            'de 2001 à 2005',
            'de 2005 à 2012',
            'à partir de 2012'
        ),
        FOREIGN KEY (user_id) REFERENCES users(id),
        PRIMARY KEY (user_id)
    );

    CREATE TABLE glazing_insulation (
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        glazing_type ENUM(
            'Simple vitrage',
            'Double vitrage ancien',
            'Double vitrage récent',
            'Triple vitrage'
        ) NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id),
        PRIMARY KEY (user_id)
    );

    CREATE TABLE ventilation (  
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        ventilation_type ENUM(
            'Ventilation par ouverture des fenêtres',
            'Ventilation mécanique auto-réglable avant 1982',
            'Ventilation mécanique auto-réglable après 1982',
            'Ventilation mécanique à extraction hygroréglable',
            'Ventilation mécanique double flux avec échangeur',
            'Ventilation mécanique double flux sans échangeur'
        ) NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id),
        PRIMARY KEY (user_id)
    );

    CREATE TABLE heating_energy_types (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        energy_type VARCHAR(50) NOT NULL
    );

    INSERT INTO heating_energy_types (energy_type) VALUES 
    ('Gaz'),
    ('Fioul'),
    ('Bois'),
    ('Electrique'),
    ('GPL'),
    ('Solaire');

    CREATE TABLE heating_systems (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        system_name VARCHAR(255) NOT NULL,
        energy_type VARCHAR(255) NOT NULL
    );

    INSERT INTO heating_systems (system_name, energy_type) VALUES 
    ('Chaudière gaz classique', 'Gaz'),
    ('Chaudière gaz Basse Température', 'Gaz'),
    ('Chaudière gaz récente à condensation', 'Gaz'),
    ('Chaudière fioul', 'Fioul'),
    ('Poêle fioul', 'Fioul'),
    ('Chaudière bois ancienne', 'Bois'),
    ('Chaudière bois récente', 'Bois'),
    ('Poêle à granulés', 'Bois'),
    ('Convecteur électrique', 'Electrique'),
    ('Panneau rayonnant électrique', 'Electrique'),
    ('PAC air/air', 'Electrique'),
    ('PAC air/eau', 'Electrique'),
    ('PAC eau/eau', 'Electrique'),
    ('PAC Géothermie', 'Electrique'),
    ('Poêle GPL', 'GPL'),
    ('Chauffage solaire', 'Solaire');





    CREATE TABLE heating_selections (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        energy_type_id INT UNSIGNED,
        heating_system_id INT UNSIGNED,
        has_chauffage_appoint BOOLEAN NOT NULL,
        energy_type VARCHAR(255),
        heating_system VARCHAR(255),
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (energy_type_id) REFERENCES heating_energy_types(id),
        FOREIGN KEY (heating_system_id) REFERENCES heating_systems(id)
    );

    CREATE TABLE hot_water_energy_types (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        energy_type VARCHAR(50) NOT NULL
    );

    INSERT INTO hot_water_energy_types (energy_type) VALUES 
    ('Gaz'),
    ('Electrique'),
    ('Système de chauffage'),
    ('Solaire'); 

    CREATE TABLE hot_water_installation_types (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        installation_type VARCHAR(255) NOT NULL,
        energy_type_id INT UNSIGNED NOT NULL,
        FOREIGN KEY (energy_type_id) REFERENCES hot_water_energy_types(id)
    );

    INSERT INTO hot_water_installation_types (installation_type, energy_type_id)
    VALUES 
        ('Chauffe-eau gaz ancien', 1), 
        ('Chauffe-eau gaz récent', 1),
        ('Chauffe-eau électrique', 2),
        ('Chauffe-eau thermodynamique', 2),
        ('Solaire avec appoint électrique', 3),
        ('Solaire avec appoint gaz', 3),
        ('Le système de chauffage', 4);


    CREATE TABLE hot_water_selections (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        energy_type_id INT UNSIGNED NOT NULL,
        installation_type_id INT UNSIGNED NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (energy_type_id) REFERENCES hot_water_energy_types(id),
        FOREIGN KEY (installation_type_id) REFERENCES hot_water_installation_types(id)
    );

    CREATE TABLE aid_estimation (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        reference_tax_income VARCHAR(255),
        household_size INT,
        is_property_older_than_15_years BOOLEAN,
        residence_type ENUM('Principale', 'Secondaire'),
        FOREIGN KEY (user_id) REFERENCES users(id)
    );

    CREATE TABLE simulation(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    `date` DATE,
    resultat TEXT,
    `codeDepart` INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
    );

    
    CREATE TABLE property(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNSIGNED NOT NULL,
    date_ajout DATE,
    adress TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
    );