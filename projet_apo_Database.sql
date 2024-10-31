-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : jeu. 31 oct. 2024 à 05:07
-- Version du serveur : 8.3.0
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `quincailleri`
--

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id_client` int NOT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `adresse` varchar(100) DEFAULT NULL,
  `ville` varchar(100) DEFAULT NULL,
  `code_postal` varchar(100) DEFAULT NULL,
  `pays` varchar(100) DEFAULT NULL,
  `telephone` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `numero_identfication` varchar(100) DEFAULT NULL,
  `date_creation` date DEFAULT NULL,
  `notes` text,
  `image_client` blob NOT NULL,
  PRIMARY KEY (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `commande_client`
--

DROP TABLE IF EXISTS `commande_client`;
CREATE TABLE IF NOT EXISTS `commande_client` (
  `id_commande` int NOT NULL,
  `id_client` int DEFAULT NULL,
  `date_commande` date NOT NULL,
  `date_livraison_prevue` date DEFAULT NULL,
  `statut` varchar(50) DEFAULT 'En cours',
  `total_ht` decimal(10,2) DEFAULT NULL,
  `total_tva` decimal(10,2) DEFAULT NULL,
  `total_ttc` decimal(10,2) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id_commande`),
  KEY `id_client` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `commande_fournisseur`
--

DROP TABLE IF EXISTS `commande_fournisseur`;
CREATE TABLE IF NOT EXISTS `commande_fournisseur` (
  `id_commande` int NOT NULL,
  `id_fournisseur` int DEFAULT NULL,
  `date_commande` date NOT NULL,
  `date_livraison_prevue` date DEFAULT NULL,
  `statut` varchar(100) DEFAULT 'En cours',
  `total_ht` decimal(10,2) DEFAULT NULL,
  `total_tva` decimal(10,2) DEFAULT NULL,
  `total_ttc` decimal(10,2) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id_commande`),
  KEY `id_fournisseur` (`id_fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `details_ventes`
--

DROP TABLE IF EXISTS `details_ventes`;
CREATE TABLE IF NOT EXISTS `details_ventes` (
  `id` int NOT NULL,
  `vente_id` int DEFAULT NULL,
  `produit_id` int DEFAULT NULL,
  `quantite` int DEFAULT NULL,
  `prix_unitaire` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vente_id` (`vente_id`),
  KEY `produit_id` (`produit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseurs`
--

DROP TABLE IF EXISTS `fournisseurs`;
CREATE TABLE IF NOT EXISTS `fournisseurs` (
  `id_fournisseur` int NOT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `prenom` varchar(100) DEFAULT NULL,
  `adresse` varchar(200) DEFAULT NULL,
  `ville` varchar(100) DEFAULT NULL,
  `code_postal` varchar(100) DEFAULT NULL,
  `pays` varchar(100) DEFAULT NULL,
  `telephone` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `numero_identification` varchar(100) DEFAULT NULL,
  `date_creation` date DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id_fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ligne_commande_client`
--

DROP TABLE IF EXISTS `ligne_commande_client`;
CREATE TABLE IF NOT EXISTS `ligne_commande_client` (
  `id_ligne_commande` int NOT NULL AUTO_INCREMENT,
  `id_commande` int NOT NULL,
  `id_produit` int NOT NULL,
  `quantite` decimal(10,2) NOT NULL,
  `prix_unitaire_ht` decimal(10,2) NOT NULL,
  `montant_ht` decimal(10,2) GENERATED ALWAYS AS ((`quantite` * `prix_unitaire_ht`)) STORED,
  PRIMARY KEY (`id_ligne_commande`),
  KEY `id_commande` (`id_commande`),
  KEY `id_produit` (`id_produit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ligne_commande_fournisseur`
--

DROP TABLE IF EXISTS `ligne_commande_fournisseur`;
CREATE TABLE IF NOT EXISTS `ligne_commande_fournisseur` (
  `id_ligne_commande` int NOT NULL,
  `id_commande` int DEFAULT NULL,
  `id_produit` int DEFAULT NULL,
  `quantite` decimal(10,2) NOT NULL,
  `prix_unitaire_ht` decimal(10,2) NOT NULL,
  `montant_ht` decimal(10,2) GENERATED ALWAYS AS ((`quantite` * `prix_unitaire_ht`)) STORED,
  PRIMARY KEY (`id_ligne_commande`),
  KEY `id_commande` (`id_commande`),
  KEY `id_produit` (`id_produit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

DROP TABLE IF EXISTS `produits`;
CREATE TABLE IF NOT EXISTS `produits` (
  `id` int NOT NULL,
  `nom` varchar(100) DEFAULT NULL,
  `prix` decimal(10,2) DEFAULT NULL,
  `quantite` int DEFAULT NULL,
  `seuil_alerte` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `recues`
--

DROP TABLE IF EXISTS `recues`;
CREATE TABLE IF NOT EXISTS `recues` (
  `id_recue` int NOT NULL,
  `id_produit` int DEFAULT NULL,
  `id_vente` int DEFAULT NULL,
  `id_client` int DEFAULT NULL,
  PRIMARY KEY (`id_recue`),
  KEY `id_produit` (`id_produit`),
  KEY `id_vente` (`id_vente`),
  KEY `id_client` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id` int NOT NULL,
  `nom` varchar(50) DEFAULT NULL,
  `role` enum('Directeur','Caissiere') DEFAULT NULL,
  `identifiant` varchar(50) DEFAULT NULL,
  `mot_de_passe` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ventes`
--

DROP TABLE IF EXISTS `ventes`;
CREATE TABLE IF NOT EXISTS `ventes` (
  `id` int NOT NULL,
  `utilisateur_id` int DEFAULT NULL,
  `date_vente` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `utilisateur_id` (`utilisateur_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande_fournisseur`
--
ALTER TABLE `commande_fournisseur`
  ADD CONSTRAINT `commande_fournisseur_ibfk_1` FOREIGN KEY (`id_fournisseur`) REFERENCES `fournisseurs` (`id_fournisseur`);

--
-- Contraintes pour la table `details_ventes`
--
ALTER TABLE `details_ventes`
  ADD CONSTRAINT `details_ventes_ibfk_1` FOREIGN KEY (`vente_id`) REFERENCES `ventes` (`id`),
  ADD CONSTRAINT `details_ventes_ibfk_2` FOREIGN KEY (`produit_id`) REFERENCES `produits` (`id`);

--
-- Contraintes pour la table `ligne_commande_client`
--
ALTER TABLE `ligne_commande_client`
  ADD CONSTRAINT `ligne_commande_client_ibfk_1` FOREIGN KEY (`id_commande`) REFERENCES `commande_client` (`id_commande`),
  ADD CONSTRAINT `ligne_commande_client_ibfk_2` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id`);

--
-- Contraintes pour la table `ligne_commande_fournisseur`
--
ALTER TABLE `ligne_commande_fournisseur`
  ADD CONSTRAINT `ligne_commande_fournisseur_ibfk_1` FOREIGN KEY (`id_commande`) REFERENCES `commande_fournisseur` (`id_commande`),
  ADD CONSTRAINT `ligne_commande_fournisseur_ibfk_2` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id`);

--
-- Contraintes pour la table `recues`
--
ALTER TABLE `recues`
  ADD CONSTRAINT `recues_ibfk_1` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id`),
  ADD CONSTRAINT `recues_ibfk_2` FOREIGN KEY (`id_vente`) REFERENCES `ventes` (`id`),
  ADD CONSTRAINT `recues_ibfk_3` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`);

--
-- Contraintes pour la table `ventes`
--
ALTER TABLE `ventes`
  ADD CONSTRAINT `ventes_ibfk_1` FOREIGN KEY (`utilisateur_id`) REFERENCES `utilisateurs` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
