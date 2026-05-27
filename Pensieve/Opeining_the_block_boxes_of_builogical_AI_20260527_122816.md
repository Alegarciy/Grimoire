# Mechanistic Interpretability of Single-Cell Foundation Models
Author Kndiukhov, I. (2026)
Read more at https://biodynai.com

What single cell foundation models have already learned about biology and how to read it

+ Mechanistic interpretability is the mathod for reading their images: is the microscrope of the foudnation 
+ Mechnistic interpretability is the **new kind of science8*

## Overview
Mechanistic Interpretability. THis is the field overview and so this conversation is how to approach the understanding research oriented and intuition of this fileds.

## Presnt
+ People right now are bulding the virtual representatino of "Virtual Cells".
+ Virtual Mpas of biology
+ Examples: Chan Zuckerber Initiave Virutal Cell porgram
+ ALl towards model rpreidction: gene exrepssion, 

## Goals
+ Benchmarking
+ Validations

## Hw foundation models work
+ Foundations models are train to predict gene expression
+ "Predicting the next token means that you udnerstand the underluign reality that let to the creation of that token" - Illya Sutskever, cofrunder of open sage superintelligence
+ What does prediction actually means, and what is the "trick" to pdoucrce this predictions
+ BUilogical models are also as a pipeline to ther kindof of models

## Extracting the map
+ The challenge is reading and turning what we eard into things builogists can actually sage
+ Caldiated apthway

## Mechanistic interpretability
+ Neuroscience of AI, what is the indfomration flaws of the network
+ Extracting inforamtion from the internals of the model
+ Features/ Circuits and ALgorithms

+ **Mechanistic INterpratibility**: Methodologies to get hte network and its interperestation is etensive
+ Mehcinistic interpretability is th eproecss of decomposition of the neural network.
+ Circuits is the combiantion fo features that ouptu another feature. Feature decomposition and identificaiton are esential in this part.

## Aplication of this to builoggy
+ Single-cell foundation models in one slide
+ Tokenized genes . GENE& GENE2 GENE9 => Transformer.masked gene prediction -> embeddings
+ scGPT and Geneformer are tokenizer for the foudnation models.
+ _What is the anatomy of a tokekn?_

+ TRUST of transcription, STRING for preotein interaction, Gene Ontologgy... other tools
+ So you have a three step pipeilnes

+ REgulatory & pathway features (GO, KEGG, Reactome, STRING, TRRUST) -> Developmental geometry (Compact Manifolds) -> Standalone Algorithmns

## Transformer Exploration

+ First you follow the next pipeline
+ Attention -> Residual Stream (your residual representaiton of token at position N stage of the transformer, it can give you an ability to interpret what is going on by the transformer)-> MLP / inter-layer

## What is this iterprability parts?
1. Attention: PCA techniques, enocdes builogy but falls reduntant for predictio
2. Geometry
3. Supeposition: There is no one to one correspondance for one neuran and one feature, a neuron is a function (linear combination of paramters with wights), you need tools to get htis ifnroatmion. Sparse on encoder.
4. Circuit Tracing
5. Extraction

## Research findings
SVD of scGPT gene embeddings at each of tis 12 layers reveals biology laid out along orthonocal spectral axis:

+ Secretory Pathway
+ Protein-protein interactions
+ Transcriptional Regulation

## Sparse Enconding
+ TopK SAEs trianed on the reasidual stream at every layer of the Gene formed adn ScGPT deomcpose dnse activiations into far larger set of sparse
+ Co-activation moudles - builogical programs scale sub-linearly with dictionary size
+ A feature will activate in this particualar genes will then trace back to which genes activation they have and the finding even non lienar they show relation for the prediction
+ So you are reverse engineering

+ Feature atlasses: ScGPT Features Atlas
+ See feature connection and then it can find a pathway for you

## Creation Coherent Circuits
+ How the algorithmsn combine to each other in a circuit format
+ DNA damage respones -> they combine into feature you can recover for each model
+ New connections about methabilc problems are hidden betwen this pathways

## Manifold: A standalone tool, surgically removed from the weights
+ LLMs a manifold is a subaspace high dimensional space inside a highdimensional space.
+ The low dimensional space inside the high dimensional space is the true encoding of the information
+ Manifolds are the knowledge encoding in the models, it ecapitulates the reality over generaiton.

### Conlsuoin
+ If manifolds represent the thought process of a neuron you woulnd't need the model algorithmsn but you would just input into the manifold
+ A new way to do buiinformations; not design algortihmns, not train algorithmns, not fine tune models, but extract algoirhtmns.
+ The first builogically useful, competitive algorithmns extracted from a foundatinon model via mechanistic intepretability

+ Traditional way design algorithmsn
+ Creat emdoels
+ train models
+ Extract inside of the models => this is a performance Andre Caparthy Software 3.0? 

## Next stpes:
+ REgulatory networks logic gap 
+ The mos toncsitant finding across every methods; these mdels encode organized builogical knowledge and co epxression but not causal regulatory logc


