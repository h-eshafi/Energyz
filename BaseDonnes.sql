
    -- Table Admin # 


    
    CREATE TABLE `admins` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `first_name` varchar(191)  DEFAULT NULL,
    `last_name` varchar(191)  DEFAULT NULL,
    `username` varchar(191)  DEFAULT NULL,
    `email` varchar(191)  NOT NULL,
    `password` varchar(191)  NOT NULL,
    `image` varchar(191)  DEFAULT NULL,
    `phone` varchar(191)  DEFAULT NULL,
    `address` text DEFAULT NULL,
    `created_at` timestamp NULL DEFAULT NULL, -- the current date On creation 

    PRIMARY KEY (`id`),
    UNIQUE KEY `admins_email_unique` (`email`),
    UNIQUE KEY `admins_username_unique` (`username`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


    LOCK TABLES `admins` WRITE;
    /*!40000 ALTER TABLE `admins` DISABLE KEYS */;
    INSERT INTO `admins` (`id`, `first_name`, `last_name`,`username`, `email`, `password`, `image`, `phone`, `address`, `created_at`)
    VALUES
        (1,'admifn','admifnLast', 'admfinUsername', 'admifn@gmail.com','example@Password.Energyz','enrergyz.jpg','123456789','paris','2021-03-08 12:58:38');
    /*!40000 ALTER TABLE `admins` ENABLE KEYS */
    UNLOCK TABLES;






    -- #Table users  

    --DROP TABLE IF EXISTS `users`;
    CREATE TABLE `users` (
    `id` int unsigned NOT NULL AUTO_INCREMENT,
    `firstname` varchar(191)  DEFAULT NULL,
    `lastname` varchar(191)  DEFAULT NULL,
    `username` varchar(191)  DEFAULT NULL,
    `email` varchar(191)  NOT NULL,
    `phone_code` varchar(15)  DEFAULT NULL,
    `phone` varchar(255)  DEFAULT NULL,
    `credits` INT NOT NULL DEFAULT '0',
    `image` varchar(191)  DEFAULT NULL,
    `address` text DEFAULT NULL , 
    `status` tinyint(1) NOT NULL DEFAULT '1',  -- Active ou pas!
    `email_verification` tinyint(1) NOT NULL DEFAULT '0',
    `password` varchar(191)  NOT NULL,
    `created_at` timestamp NULL DEFAULT NULL, 

    PRIMARY KEY (`id`),
    UNIQUE KEY `users_email_unique` (`email`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;





    -- #Table posts  ------------------------------------------------------------ 


    CREATE TABLE `posts` (
        `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        `title` VARCHAR(255) NOT NULL,
        `content` TEXT NOT NULL,
        `author_id` INT UNSIGNED,
        `author_name` VARCHAR(255) NOT NULL ,        
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (`author_id`) REFERENCES `users`(`id`),
        FOREIGN KEY (`author_id`) REFERENCES `admins`(`id`)
    );

        -- #Table comments  ------------------------------------------------------------ 


    CREATE TABLE comments (   -- Requires login to comment
        `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        `post_id` INT UNSIGNED,
        `user_id` INT UNSIGNED,
        `content` TEXT NOT NULL,
        `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
        FOREIGN KEY (`post_id`) REFERENCES posts(`id`),
        FOREIGN KEY (`user_id`) REFERENCES users(`id`)
    );


     /*-- #Table newsletter   ------------------------------------------------------------*/


     CREATE TABLE newletter_emails (
    `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(50) NOT NULL,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `subscribed_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY `subscriber_email_unique` (`email`)
        );


    
  -- 1#Table data general   ------------------------------------------------------------ */

    CREATE TABLE general_data (
        -- `id` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        `Code_du_département` INT UNSIGNED NOT NULL,
        `Nom_stimulation` VARCHAR(255) NOT NULL,
        `département` VARCHAR(255) NOT NULL,
        `Année_de_construction` ENUM(
            'Avant 1975',
            'de 1975 à 1977',
            'de 1978 à 1982',
            'de 1983 à 1988',
            'de 1989 à 2000',
            'de 2001 à 2005',
            'de 2005 à 2012',
            'à partir de 2012'
        ) NOT NULL,
        `Forme_du_logement` ENUM(
            'Carré',
            'Rectangulaire',
            'Forme en L',
            'Forme en U'
        ) NOT NULL,
        `Mitoyenneté` ENUM(
            'Mitoyenne sur 2 côtés',
            'Mitoyenne sur un côté',
            'Indépendante (4 façades)'
        ) NOT NULL,
        `Nombre_de_niveaux` ENUM(
            '1 niveau (rez)',
            '2 niveaux (rez+1)',
            '3 niveaux ou + (rez+2 ou plus)'
        ) NOT NULL,
        `Surface_habitable` VARCHAR(255) NOT NULL,

        -- FOREIGN KEY (user_id) REFERENCES user(id),
        -- FOREIGN KEY (property_id) REFERENCES property(id),
        PRIMARY KEY (user_id, property_id),

        UNIQUE KEY `department_code_unique` (`Code_du_département`)

    );

    
          -- #Table property  ------------------------------------------------------------ 

              --this table is just for storing the data about the property that'll be shown to the user in his propreties table
    CREATE TABLE `property` (
        `id` int unsigned NOT NULL AUTO_INCREMENT,  
        `Nom_proprety` VARCHAR(255) NOT NULL,
        `user_id` int unsigned NOT NULL,            -- Foreign key referencing the user table  
        `result_txt` text DEFAULT NULL,             -- txt resultat de    stimulation (optionel
        `address` text DEFAULT NULL,             -- Adress 
        `date_creation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the stimulation was created

        UNIQUE KEY `property_nom_unique` (`Nom_proprety`),
        FOREIGN KEY (user_id) REFERENCES users(id),   -- Foreign key constraint referencing user.id  
        PRIMARY KEY (`id`)                          -- Primary key on the id column
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




  -- #Table stimulations  ------------------------------------------------------------ 
    CREATE TABLE `stimulation` (
        `user_id` INT UNSIGNED NOT NULL,
        `property_id` int unsigned NOT NULL,        -- Foreign key referencing the property table
        `id` int unsigned NOT NULL AUTO_INCREMENT,  -- Unique identifier for each stimulation
        `Nom_stimulation` VARCHAR(255) NOT NULL,
        `result_image` varchar(255) DEFAULT NULL,   -- Path or URL to the result image (optional)
        `result_txt` text DEFAULT NULL,             -- Textual result of the stimulation (optional)
        `date_creation` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP, -- Date and time when the stimulation was created

        PRIMARY KEY (`id`),                          -- Primary key on the id column
        UNIQUE KEY `stimulation_nom_unique` (`Nom_stimulation`),
        FOREIGN KEY (user_id) REFERENCES users(id),   -- Foreign key constraint referencing user.id (assuming a user table named 'user' exists)
        FOREIGN KEY (property_id) REFERENCES property(id)  -- Foreign key constraint referencing property.id
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;













-- 2#Enveloppe thermique With forein keys */




    -- Table for Wall Insulation Data

    CREATE TABLE murs_isolation (
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        is_insulated ENUM('Oui', 'Non') NOT NULL,
        Année_isolation ENUM(
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
        FOREIGN KEY (property_id) REFERENCES property(id),
        PRIMARY KEY (user_id, property_id)
    );



    -- Table for Floor Insulation Data


    CREATE TABLE  Plancher_bas (
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        Type_plancher_bas ENUM(
            'Sur vide sanitaire ou sous-sol',
            'Sur terre-plein'
        ) NOT NULL,
        is_insulated ENUM('Oui', 'Non') NOT NULL,
        Année_Isolation ENUM(
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
        FOREIGN KEY (property_id) REFERENCES property(id),
        PRIMARY KEY (user_id, property_id)
    );



  -- Table for Upper Floor Insulation Data


    CREATE TABLE Plancher_haut (
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        nature ENUM(
            'Combles perdus (combles)',
            'Combles aménagés (combles)',
            'Toiture terrasse'
        ),
        is_insulated ENUM('Oui', 'Non') NOT NULL,
        Année_isolation ENUM(
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
        FOREIGN KEY (property_id) REFERENCES property(id),
        PRIMARY KEY (user_id, property_id)
    );






 

  -- Table for Glazing Insulation Data (Vitrage)


    CREATE TABLE vitrage (
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        Type_de_vitrage ENUM(
            'Simple vitrage',
            'Double vitrage ancien',
            'Double vitrage récent',
            'Triple vitrage'
        ) NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (property_id) REFERENCES property(id),
        PRIMARY KEY (user_id, property_id)
    );








--     iouiuioio 3.Systèmes énergétiques 



  -- Table for Ventilation Data
    CREATE TABLE ventilation (
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        Type_de_ventilation  ENUM(
            'Ventilation par ouverture des fenêtres',
            'Ventilation mécanique auto-réglable avant 1982',
            'Ventilation mécanique auto-réglable après 1982',
            'Ventilation mécanique à extraction hygroréglable',
            'Ventilation mécanique double flux avec échangeur',
            'Ventilation mécanique double flux sans échangeur'
        ) NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (property_id) REFERENCES property(id),
        PRIMARY KEY (user_id, property_id)
    );









  --  Chauffage_principale



    -- Table for Chauffage_principale energy types
    CREATE TABLE Chauffage_principale_types (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        energy_type VARCHAR(50) NOT NULL
    );

    -- Insert data into heating energy types table
    INSERT INTO Chauffage_principale_types (energy_type) VALUES 
    ('Gaz'),
    ('Fioul'),
    ('Bois'),
    ('Electrique'),
    ('GPL'),
    ('Solaire');


    -- Table for Chauffage_principale Systems   ///-e
    
    CREATE TABLE Chauffage_principale_systems (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        system_name VARCHAR(255) NOT NULL,
        energy_type VARCHAR(255) NOT NULL
    );



    -- Insert Heating Systems Data
    INSERT INTO Chauffage_principale_systems (system_name, energy_type) VALUES 
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

    

    -- Table for Chauffage_principale selections

    CREATE TABLE Chauffage_principale_selections (
        -- id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        energy_type_id INT UNSIGNED NOT NULL,
        heating_system_id INT UNSIGNED NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (property_id) REFERENCES property(id),
        FOREIGN KEY (energy_type_id) REFERENCES Chauffage_principale_types(id),
        FOREIGN KEY (heating_system_id) REFERENCES Chauffage_principale_systems(id),

        PRIMARY KEY (user_id, property_id)
    );














  --   Chauffage d'appoint



    -- Table for heating energy types
    CREATE TABLE Chauffage_appoint_types (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        energy_type VARCHAR(50) NOT NULL
    );

    -- Insert data into heating energy types table
    INSERT INTO Chauffage_appoint_types (energy_type) VALUES 
    ('Gaz'),
    ('Fioul'),
    ('Bois'),
    ('Electrique'),
    ('GPL'),
    ('Solaire');

    -- Table for Heating Systems
    CREATE TABLE Chauffage_appoint_systems (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        system_name VARCHAR(255) NOT NULL,
        energy_type VARCHAR(255) NOT NULL
    );

    -- Insert Heating Systems Data
    INSERT INTO Chauffage_appoint_systems (system_name, energy_type) VALUES 
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
    ('Poêle GPL', 'GPL');


    -- Table for Chauffage d'   appoint selections

    CREATE TABLE Chauffage_appoint_selections (

        -- id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        energy_type_id INT UNSIGNED,
        has_chauffage_appoint ENUM('Oui', 'Non') NOT NULL,
        heating_system_id INT UNSIGNED,
        energy_type VARCHAR(255),
        heating_system VARCHAR(255),

        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (property_id) REFERENCES property(id),
        FOREIGN KEY (energy_type_id) REFERENCES Chauffage_appoint_types(id),
        FOREIGN KEY (heating_system_id) REFERENCES Chauffage_appoint_systems(id),

        PRIMARY KEY (user_id, property_id)
    );







  -- Eau_chaud sanitaire 




    -- Table for Eau chaude sanitaire types

    CREATE TABLE Types_energie_de_production (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        energy_type VARCHAR(50) NOT NULL
    );

    -- Insert data into hot water energy types table
    INSERT INTO Types_energie_de_production (energy_type) VALUES 
    ('Gaz'),
    ('Electrique'),
    ('Système de chauffage'),
    ('Solaire'); 



    -- Table for hot water installation types
    CREATE TABLE Type_installation_ECS (
        id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        installation_type VARCHAR(255) NOT NULL,
        energy_type_id INT UNSIGNED   ,
        FOREIGN KEY (energy_type_id) REFERENCES Types_energie_de_production(id)
    ); 

    -- Insert data into hot water installation types table
    INSERT INTO Type_installation_ECS (installation_type, energy_type) VALUES 
    ('Chauffe-eau gaz ancien', 'Gaz'), 
    ('Chauffe-eau gaz récent', 'Gaz'),
    ('Chauffe-eau électrique', 'Electrique'),
    ('Chauffe-eau thermodynamique', 'Electrique'),
    ('Solaire avec appoint électrique', 'Solaire'),
    ('Solaire avec appoint gaz', 'Solaire'),
    ('Le système de chauffage', 'Système de chauffage'); 




    -- Table for storing hot water selections
    CREATE TABLE Eau_chaud_selections (
        -- id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, --the id 2odfof
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        energy_type_id INT UNSIGNED NOT NULL,
        installation_type_id INT UNSIGNED NOT NULL,
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (property_id) REFERENCES property(id),
        FOREIGN KEY (energy_type_id) REFERENCES Types_energie_de_production(id),
        FOREIGN KEY (installation_type_id) REFERENCES Type_installation_ECS(id),

        PRIMARY KEY (user_id, property_id)
    );



-- next , laravel 







-- 4. Mon foyer 

  -- Table for estimating aid


    CREATE TABLE Chiffrage_des_aides (
        -- id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
        user_id INT UNSIGNED NOT NULL,
        property_id INT UNSIGNED NOT NULL,
        Revenu_fiscal VARCHAR(255), -- Revenu fiscal de référence (free text)
        nbr_personnes INT, -- Number of people in the household including the user
        is_property_older_than_15_years ENUM('Oui', 'Non') NOT NULL, -- Is the property at least 15 years old?
        titre_de_residence ENUM('Principale', 'Secondaire'), -- Type of residence
        FOREIGN KEY (user_id) REFERENCES users(id),
        FOREIGN KEY (property_id) REFERENCES property(id),
        PRIMARY KEY (user_id, property_id)
    );






