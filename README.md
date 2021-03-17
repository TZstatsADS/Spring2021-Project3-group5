# Project: Can you recognize the emotion from an image of a face?
<img src="figs/CE.jpg" alt="Compound Emotions" width="500"/>
(Image source: https://www.pnas.org/content/111/15/E1454)

### [Full Project Description](doc/project3_desc.md)

Term: Spring 2021

+ Team 5
+ Team members
	+ Jingbin Cao
	+ Chuanchuan Liu
	+ Dennis Shpits
	+ Yingyao Wu
	+ Zikun Zhuang

+ Project summary: In this project, we created a classification engine for facial emotion recognition. We built five models, GBM model with default feature (baseline model), Random Forest Model (RF), Support Vector Machine (SVM), Ridge Regression Model, and Principal Component Analysis + Linear Discriminate Anawlysis (PCA+LDA). We received 3000 images from xxx, and split them into 2400 training images and 600 testing images. We used SMOTE and ROSE method to balance the training data, and RF and SVM models have better performance than the baseline model.

**Contribution statement**: ([default](doc/a_note_on_contributions.md)) All team members contributed equally in all stages of this project. All team members approve our work presented in this GitHub repository including this contributions statement.  
All team members attended all weekly project meetings.

Jingbin Cao: Built Random Forest Model （with， ROSE balanced, SMOTE balanced method, and imbalanced for training data). Also built RF model with old features. Tuned the hyperparamters for all Random Forest Model.

Chuanchuan Liu: Worked on Ridge model, balanced data and fine-tuned the parameter.

Dennis Shpits (Presenter): Worked on the GBM Baseline model, built new feature function, and made presentation slides.

Yingyao Wu: Worked on SVM model using both linear and radial basis kernel methods; organized and cleaned up the main file.

Zikun Zhuang: Balanced the data, worked with PCA and LDA model, and tunning the hyper-parameter。


Following [suggestions](http://nicercode.github.io/blog/2013-04-05-projects/) by [RICH FITZJOHN](http://nicercode.github.io/about/#Team) (@richfitz). This folder is orgarnized as follows.

```
proj/
├── lib/
├── data/
├── doc/
├── figs/
└── output/
```

Please see each subfolder for a README file.
