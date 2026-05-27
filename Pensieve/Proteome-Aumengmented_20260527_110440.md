# Proteome-Aumengmented

Author: Dewei Hu
University: Univeristy of Kopenhavn

## Overview
+ Multiomics for extracting data
+ Metabolomics and Proteomics => Metabolimics cheap scalable many samples and Proteomics expensive niche and few samples
+ UK builbanc survival modeling proemics advantaged
+ Comparing the Metabolomics C-INdex and Proteomics C-Index
+ Is it transferable the Promics to Metabolomics

## Search of connection
+ How Plasma Proteins and Metabolites Are coneccted
+ Four waysL TAXI REACTOR SHARED FATE

## CA Methodolodies to trian model
+ Multi layer perceptron
+ Ridge regression
+ Transformed
+ CLIP (this is the forte of this converation, how can we achieve effieincy)
+ FedCoder

This models are for testing, first start from the baseline: 
The data set is 170 metabolanoes but normally you have thousands of them. So the baseline data is really bad, trianing the model means nothing.

+ Using Ridge Regression: Metabilomics to Proteomics
+ Second: MLP 
+ Proteomics => Reconstructions
+ Metabolomis => Recontrauction

An expert in the field say how come you train 170 metabolones normally you will have thousands of them!!!

## Project Idea
Apply better benchmarking to the idea, actually find meaningful training data that will predict the quality of the if nding

They are stating the enxt:
+ Proteomics advantaged set => and the reaminaing set

The pipeline is:
+ From Metabolomics -> Promeonics -> measure error -> then predict the diseases

The machine learning model:
+ Is this the internal representations is better

## General idea of this experimentation
+ So preomonics are better at identifiyign disieases. Metabolonics are not, but they are cheap the question been can a relation between them encourage a model to predict better adjsuted with the dieseason. Now with the protons data can predict the disease. The delta C-Index are indicator fo the Numebr of disease cases.
+ The trick is to identify the biological marker

## Pipelines

+ 1. Metabolonics -> Protonics
+ 2. Protonics -> Diesese
+ 3. Metabolonics -> pronoics

The issue is that you are not creating new data, the models should start doing prediction. Prediciton of disiesase Pronotincs and Metbaoloncis are predicting the same, because they are trianed on protein but there is missdirection of the disease. 

## Referecnes:
+ Cener basic metabolic researc
+ Biobanck
+ Human Phenotype Project
+ University of Cophehagegen
