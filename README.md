# Delay Embedding
Time series modeling and classification based on delay embedding. This is an improved version of ["Derivative Delay Embedding: Online Modeling of Streaming Time Series"](https://arxiv.org/pdf/1609.07540v1.pdf). 

* [Pre-requisites](#Requirements)
* [Running the Test](#Running)
* [Preliminary Results](#Result)
* [Folders and Files](#Folders)
* [Citation](#Citation)

<a name="Requirements">

## Pre-requisites 
Matlab (the code has been tested on Matlab 2015a)

<a name="Running">

## Running the test
Run `MAIN.m`
```
>> MAIN
```

<a name="Result">

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

Compare to the state-of-the-art algorithms

| | [Moving poselets](http://www.cv-foundation.org//openaccess/content_iccv_2015_workshops/w11/papers/Tao_Moving_Poselets_A_ICCV_2015_paper.pdf)<br>(ICCV2015) | [dRNN](http://www.cv-foundation.org/openaccess/content_iccv_2015/papers/Veeriah_Differential_Recurrent_Neural_ICCV_2015_paper.pdf)<br>(ICCV2015) | [HBRNN](http://www.cv-foundation.org/openaccess/content_cvpr_2015/papers/Du_Hierarchical_Recurrent_Neural_2015_CVPR_paper.pdf)<br>(CVPR2015) | [Actionlets & Poselets](http://www.cv-foundation.org/openaccess/content_cvpr_2016/papers/Lillo_A_Hierarchical_Pose-Based_CVPR_2016_paper.pdf)<br>(CVPR2016)| Our method<br>(2016) |
|---|:---:|:---:|:---:|:---:|:---:|
| **Accuracy** | 93.6% | 92.03% | 94.49%* | 93.0% | 93.77% / 94.52%* |

*Note: the * marker denotes the results from subsets, which is usually higher than that from the whole dataset*

<a name="Folders">

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

<a name="Citation">

## Related Work
Zhifei Zhang, Yang Song, Wei Wang, and Hairong Qi. "Derivative Delay Embedding: Online Modeling of Streaming Time Series". *The 25th ACM International Conference on Information and Knowledge Management (CIKM)*, 2016. [[PDF](https://arxiv.org/pdf/1609.07540v1.pdf)] 

```
@inproceedings{zhang2016derivative,
  title={Derivative Delay Embedding: Online Modeling of Streaming Time Series},
  author={Zhang, Zhifei and Song, Yang and Wang, Wei and Qi, Hairong},
  booktitle={Proceedings of the 25th ACM International on Conference on Information and Knowledge Management},
  pages={969--978},
  year={2016},
  organization={ACM}
}
```

[Presentation on CIKM2016](https://www.dropbox.com/s/k68m8ckn17af9ae/CIKM2016_presentation.ppsx?dl=0). If it is not availabel, please refer to the [PDF](https://www.dropbox.com/s/j74yddhbo9iledz/CIKM2016_presentation.pdf?dl=0) version.
