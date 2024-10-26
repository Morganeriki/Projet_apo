-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 25 oct. 2024 à 13:01
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
-- Base de données : `quincaillerie`
--

-- --------------------------------------------------------

--
-- Structure de la table `employe`
--

DROP TABLE IF EXISTS `employe`;
CREATE TABLE IF NOT EXISTS `employe` (
  `id_employe` smallint NOT NULL AUTO_INCREMENT,
  `Nom_complet` varchar(50) DEFAULT NULL,
  `Adresse` tinytext,
  `Numero_telephone` decimal(10,0) DEFAULT NULL,
  `Email` tinytext,
  `Date_de_naissance` date DEFAULT NULL,
  `Date_embauche` date DEFAULT NULL,
  `Poste` varchar(40) DEFAULT NULL,
  `Taux_horaire` decimal(10,2) DEFAULT NULL,
  `Type_de_contrat` varchar(15) DEFAULT NULL,
  `Statut` enum('actif','conge','demissionne','licencie','malade','absent') DEFAULT NULL,
  `Numero_securite_sociale` varchar(14) DEFAULT NULL,
  `Superviseur` varchar(50) DEFAULT NULL,
  `Notes` enum('Tres bien','Bien','Satisfaissant','Insuffisant') DEFAULT NULL,
  `Evaluations` text,
  `Permissions` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_employe`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `fournisseur`
--

DROP TABLE IF EXISTS `fournisseur`;
CREATE TABLE IF NOT EXISTS `fournisseur` (
  `id_fournisseur` smallint NOT NULL AUTO_INCREMENT,
  `Nom_fournisseur` varchar(50) DEFAULT NULL,
  `adresse` tinytext,
  `Numero_telepone` decimal(10,0) DEFAULT NULL,
  `Email` tinytext,
  `personne_contacter` text,
  `site_web` tinytext,
  `Numero_TVA` char(13) DEFAULT NULL,
  `Condition_paiement` tinytext,
  `Mode_livraison` varchar(60) DEFAULT NULL,
  `Produit_fournis` text,
  `Reduction` tinytext,
  `Statut` enum('actif','inactif','en_negociation') DEFAULT NULL,
  `Notes` set('fiable','non_fiable','qualite_service','qualite_produit') DEFAULT NULL,
  `Date_ajout` date DEFAULT NULL,
  `Numero_compte_bancaire` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id_fournisseur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
