-- Base de données pour la gestion du parc automobile
CREATE DATABASE IF NOT EXISTS parc_auto_gestion;
USE parc_auto_gestion;

-- Table des véhicules
CREATE TABLE IF NOT EXISTS vehicules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    marque VARCHAR(100) NOT NULL,
    modele VARCHAR(100) NOT NULL,
    immatriculation VARCHAR(20) UNIQUE NOT NULL,
    annee INT NOT NULL,
    kilometrage INT DEFAULT 0,
    type_carburant ENUM('Essence', 'Diesel', 'Hybride', 'Electrique') NOT NULL,
    statut ENUM('Disponible', 'En_service', 'Maintenance', 'Hors_service') DEFAULT 'Disponible',
    date_acquisition DATE,
    prix_acquisition DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table des affectations (extension)
CREATE TABLE IF NOT EXISTS affectations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vehicule_id INT,
    conducteur_nom VARCHAR(100) NOT NULL,
    conducteur_prenom VARCHAR(100) NOT NULL,
    service VARCHAR(100),
    date_debut DATE NOT NULL,
    date_fin DATE,
    motif VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicule_id) REFERENCES vehicules(id) ON DELETE CASCADE
);

-- Table de la maintenance (extension)
CREATE TABLE IF NOT EXISTS maintenance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vehicule_id INT,
    type_maintenance ENUM('Revision', 'Reparation', 'Controle_technique', 'Autre') NOT NULL,
    description TEXT,
    date_maintenance DATE NOT NULL,
    cout DECIMAL(10,2),
    garage VARCHAR(100),
    kilometrage_maintenance INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicule_id) REFERENCES vehicules(id) ON DELETE CASCADE
);

-- Données d'exemple
INSERT INTO vehicules (marque, modele, immatriculation, annee, kilometrage, type_carburant, statut, date_acquisition, prix_acquisition) VALUES
('Toyota', 'Corolla', 'ABC-123-MA', 2020, 35000, 'Essence', 'Disponible', '2020-01-15', 180000.00),
('Renault', 'Duster', 'DEF-456-MA', 2019, 42000, 'Diesel', 'En_service', '2019-03-10', 220000.00),
('Hyundai', 'Tucson', 'GHI-789-MA', 2021, 28000, 'Hybride', 'Disponible', '2021-06-20', 280000.00),
('Dacia', 'Logan', 'JKL-012-MA', 2018, 65000, 'Diesel', 'Maintenance', '2018-09-05', 120000.00);