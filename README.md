# Delay Embedding
Delay embedding for time series modeling and classification

* [Requirements](#Requirements)
* [Running the Test](#Running)
* [Preliminary Results](#Result)
* [Folders and Files](#Folders)
* [Citation](#Citation)

<a name="Requirements"/>
## Requirements 
Matlab (the code has been tested on Matlab 2015a)

<a name="Running"/>
## Running the test
Run `MAIN.m`
```
>> MAIN
```

<a name="Result"/>
## Preliminary Results
The running print on MSR Action 3D dataset is shown as follow
```
Processing the MSR_Action3D dataset 
Trained 50 / 284
Trained 100 / 284
Trained 150 / 284
Trained 200 / 284
Trained 250 / 284
tested 50 / 273
tested 100 / 273
tested 150 / 273
tested 200 / 273
tested 250 / 273
Training time: 2.670sec, 0.009sec per sample
Testing time: 16.898sec, 0.062sec per sample
Accuracy = 93.77%
```
| | RNN | HON4D | Moving pose | Lie algebra | Moving poselets |
|---|---|---|---|---|---|
| 89.9% |

<a name="Folders"/>
## Folders and Files
* [DE](https://github.com/ZZUTK/Delay_Embedding/tree/master/DE) implements Delay Embedding
 * `delayEmbeding.m` implements 1-D delay embedding
 * `delayEmbedingND.m` implements multi-dimensional delay embedding
* [MGM](https://github.com/ZZUTK/Delay_Embedding/tree/master/MGM) learns Markov Geographic Model
 * `createGrid.m` creates discretized embedding space.
 * `add2Trans.m` records learned transition
 * `Trans_Prob.m` computes transition probability
 * `HDist.m` calculates distance between a testing sample and learned model (transition probability) 
* [data](https://github.com/ZZUTK/Delay_Embedding/tree/master/data) 
 * `MSR_Action3D.mat` is the [MSR Action3D dataset](http://research.microsoft.com/en-us/um/people/zliu/actionrecorsrc/)
 * `UCI_CharacterTrajectories.mat` is the [Character Trajectories Data Set ](https://archive.ics.uci.edu/ml/datasets/Character+Trajectories) from UCI
 * `setting_MSR.m` and `setting_UCI.m` are settings for the two datasets used in `MAIN.m`
* [utilities](https://github.com/ZZUTK/Delay_Embedding/tree/master/utilities)
 * `confusionMatrix.m` plots the confusion matrix
 * `defaultColors.mat` stores the default color map of Matlab
 * `lowpassFilter.m` performs low-pass filter to filter the raw data

<a name="Citation"/>
## Citation
Zhifei Zhang, Yang Song, Wei Wang, and Hairong Qi. "Derivative Delay Embedding: Online Modeling of Streaming Time Series". *CIKM*, 2016. 

