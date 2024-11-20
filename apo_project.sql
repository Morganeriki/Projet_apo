-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 05 nov. 2024 à 18:57
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
-- Base de données : `apo_project`
--

-- --------------------------------------------------------

--
-- Structure de la table `appartenaces`
--

DROP TABLE IF EXISTS `appartenaces`;
CREATE TABLE IF NOT EXISTS `appartenaces` (
  `id_produit` bigint NOT NULL,
  `id_categorie` bigint NOT NULL,
  `id_stock` bigint NOT NULL,
  PRIMARY KEY (`id_produit`,`id_categorie`,`id_stock`),
  KEY `id_categorie` (`id_categorie`),
  KEY `id_stock` (`id_stock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id_categorie` bigint NOT NULL AUTO_INCREMENT,
  `nom_categorie` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_categorie`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

DROP TABLE IF EXISTS `clients`;
CREATE TABLE IF NOT EXISTS `clients` (
  `id_client` bigint NOT NULL AUTO_INCREMENT,
  `nom_client` varchar(100) DEFAULT NULL,
  `prenom_client` varchar(100) DEFAULT NULL,
  `image_client` blob,
  `adresse_client` tinytext,
  PRIMARY KEY (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `details_founitures`
--

DROP TABLE IF EXISTS `details_fournitures`;
CREATE TABLE IF NOT EXISTS `details_founitures` (
  `id_details_fourniture` bigint NOT NULL AUTO_INCREMENT,
  `quantite_fournis` int DEFAULT NULL,
  `taux_tva` int DEFAULT NULL,
  `prix_unitaire` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_details_fourniture`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `details_ventes`
--

DROP TABLE IF EXISTS `details_ventes`;
CREATE TABLE IF NOT EXISTS `details_ventes` (
  `id_details_ventes` bigint NOT NULL AUTO_INCREMENT,
  `quantite_vendu` int DEFAULT NULL,
  `prix_unitaire` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_details_ventes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `enregistrements`
--

DROP TABLE IF EXISTS `enregistrements`;
CREATE TABLE IF NOT EXISTS `enregistrements` (
  `id_client` bigint NOT NULL,
  `id_utilisateur` bigint NOT NULL,
  `id_recue` bigint NOT NULL,
  `date_enregistrement` date DEFAULT NULL,
  PRIMARY KEY (`id_client`,`id_utilisateur`,`id_recue`),
  KEY `id_utilisateur` (`id_utilisateur`),
  KEY `id_recue` (`id_recue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `founitures`
--

DROP TABLE IF EXISTS `founitures`;
CREATE TABLE IF NOT EXISTS `founitures` (
  `id_details_fourniture` bigint NOT NULL,
  `id_produit` bigint NOT NULL,
  `id_fournisseur` bigint NOT NULL,
  `date_de_commande` date DEFAULT NULL,
  `date_de_livraison` date DEFAULT NULL,
  `prix_total_avec_tva` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_details_fourniture`,`id_produit`,`id_fournisseur`),
  KEY `id_produit` (`id_produit`),
  KEY `id_fournisseur` (`id_fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseurs`
--

DROP TABLE IF EXISTS `fournisseurs`;
CREATE TABLE IF NOT EXISTS `fournisseurs` (
  `id_fournisseur` bigint NOT NULL AUTO_INCREMENT,
  `nom_fourniseur` varchar(100) DEFAULT NULL,
  `email` tinytext,
  `telephone` decimal(20,0) DEFAULT NULL,
  `adresse_fournisseur` tinytext,
  PRIMARY KEY (`id_fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

DROP TABLE IF EXISTS `produits`;
CREATE TABLE IF NOT EXISTS `produits` (
  `id_produit` bigint NOT NULL AUTO_INCREMENT,
  `libelle_produit` varchar(100) DEFAULT NULL,
  `prix_unitaire` decimal(10,2) DEFAULT NULL,
  `quantite_disponible` bigint DEFAULT NULL,
  `seuil` bigint DEFAULT NULL,
  PRIMARY KEY (`id_produit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `recues`
--

DROP TABLE IF EXISTS `recues`;
CREATE TABLE IF NOT EXISTS `recues` (
  `id_recue` bigint NOT NULL AUTO_INCREMENT,
  `taux_de_tva` decimal(10,2) DEFAULT NULL,
  `prix_total_avec_tva` decimal(10,2) DEFAULT NULL,
  `id_utilisateur` bigint DEFAULT NULL,
  PRIMARY KEY (`id_recue`),
  KEY `id_utilisateur` (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `stocks`
--

DROP TABLE IF EXISTS `stocks`;
CREATE TABLE IF NOT EXISTS `stocks` (
  `id_stock` bigint NOT NULL AUTO_INCREMENT,
  `nom_stock` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_stock`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

DROP TABLE IF EXISTS `utilisateurs`;
CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id_utilisateur` bigint NOT NULL AUTO_INCREMENT,
  `nom_utilisateur` varchar(100) DEFAULT NULL,
  `prenom_utilisateur` varchar(100) DEFAULT NULL,
  `role_utilisateur` enum('Caissiere','Directeur') DEFAULT NULL,
  `identifiant_utilisateur` varchar(50) DEFAULT NULL,
  `mot_de_passe_utilisateur` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `vendeurs`
--

DROP TABLE IF EXISTS `vendeurs`;
CREATE TABLE IF NOT EXISTS `vendeurs` (
  `id_vendeur` bigint NOT NULL AUTO_INCREMENT,
  `nom_vendeur` varchar(100) DEFAULT NULL,
  `prenom_vendeur` varchar(100) DEFAULT NULL,
  `telephone` decimal(20,0) DEFAULT NULL,
  `adresse_vendeur` tinytext,
  PRIMARY KEY (`id_vendeur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ventes`
--

DROP TABLE IF EXISTS `ventes`;
CREATE TABLE IF NOT EXISTS `ventes` (
  `id_produit` bigint NOT NULL,
  `id_vendeur` bigint NOT NULL,
  `id_details_ventes` bigint NOT NULL,
  `id_client` bigint DEFAULT NULL,
  `date_vente` date DEFAULT NULL,
  `prix_total_ht` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_vendeur`,`id_produit`,`id_details_ventes`),
  KEY `id_produit` (`id_produit`),
  KEY `id_details_ventes` (`id_details_ventes`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `appartenaces`
--
ALTER TABLE `appartenaces`
  ADD CONSTRAINT `appartenaces_ibfk_1` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id_produit`),
  ADD CONSTRAINT `appartenaces_ibfk_2` FOREIGN KEY (`id_categorie`) REFERENCES `categories` (`id_categorie`),
  ADD CONSTRAINT `appartenaces_ibfk_3` FOREIGN KEY (`id_stock`) REFERENCES `stocks` (`id_stock`);

--
-- Contraintes pour la table `enregistrements`
--
ALTER TABLE `enregistrements`
  ADD CONSTRAINT `enregistrements_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`),
  ADD CONSTRAINT `enregistrements_ibfk_2` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id_utilisateur`),
  ADD CONSTRAINT `enregistrements_ibfk_3` FOREIGN KEY (`id_recue`) REFERENCES `recues` (`id_recue`);

--
-- Contraintes pour la table `founitures`
--
ALTER TABLE `founitures`
  ADD CONSTRAINT `founitures_ibfk_1` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id_produit`),
  ADD CONSTRAINT `founitures_ibfk_2` FOREIGN KEY (`id_details_fourniture`) REFERENCES `details_founitures` (`id_details_fourniture`),
  ADD CONSTRAINT `founitures_ibfk_3` FOREIGN KEY (`id_fournisseur`) REFERENCES `fournisseurs` (`id_fournisseur`);

--
-- Contraintes pour la table `recues`
--
ALTER TABLE `recues`
  ADD CONSTRAINT `recues_ibfk_1` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateurs` (`id_utilisateur`);

--
-- Contraintes pour la table `ventes`
--
ALTER TABLE `ventes`
  ADD CONSTRAINT `ventes_ibfk_1` FOREIGN KEY (`id_produit`) REFERENCES `produits` (`id_produit`),
  ADD CONSTRAINT `ventes_ibfk_2` FOREIGN KEY (`id_vendeur`) REFERENCES `vendeurs` (`id_vendeur`),
  ADD CONSTRAINT `ventes_ibfk_3` FOREIGN KEY (`id_details_ventes`) REFERENCES `details_ventes` (`id_details_ventes`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
