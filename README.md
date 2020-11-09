# USAccidentsSeverity
Analysis and Prediction of the Severity of US Accidents from 2016-2019

## Summary

The US Accidents dataset incorporated in this project is a public dataset that is a compilation of countrywide accident details spanning 49 states from 2016 to 2019. There are around 3 million records in this dataset with information regarding location of accident, weather conditions present, unique description of the accident using a TMC (Traffic Message code), severity of the incident, and significant structures nearby. This traffic data is captured through various sources like websites, law enforcement websites, and state-mandated motor vehicle agencies.

The dataset can be found here at https://www.kaggle.com/sobhanmoosavi/us-accidents.

## Objectives 

1. Perform exploratory data analysis on this dataset and try to generate insights about traffic accidents in the U.S. 
2. Predict accident severity levels based on traffic accident records by using various models.

## Implementation 

Primarily, data preprocessing was done before performing any data analysis of modeling. This consisted of loading the data and packages and tidying the data to remove null values. All variables with a high NA proportion of over fifty percent were dropped and the remaining variables had their NA values replaced with mean values. Afterwards, variables like severity were determined to be specified as factors in order to be used later for modeling. Severity was then further grouped from four levels into two levels. The dataset itself was consolidated to consist of only the top ten states with accidents to avoid overfitting and run the models faster. 

In addition, variables deemed redundant and trivial to severity were dropped. A couple examples of this are Airport Code which gives the location of the accident and overlaps with other columns like State, City and County, and Turning Loop which contained all False values. Consequently, all near zero variance predictors were removed as they have less predictive power. The dataset was then portioned into test, training, and validation sets. The preprocessing stage was concluded by utilizing oversampling and under sampling to make the two levels, “Severe” and “Not Severe” more balanced.

Next, during the modeling phase, the models were fitted to predict severity through logistic and sparse logistic regression, decision tree, and random forest.  Logistic regression was the base line model used. Using stepwise model selection and Akaike information criterion (AIC), variables were selected to get the best formula and predictions were made on the final dataset. Since there were many variables with several levels, most of them were coefficient zero when the stepwise model was built. Our sparse logistic regression used the “lasso” penalty parameter to improve upon the existing logistic regression model. As the tuning parameter increases, more variables will be forced to have coefficient zero. Upon finding the best lambda value, the prime sparse model containing predictions was made. Here, different cutoff values impacted the final performance.
On the other hand, tree-based algorithms like decision tree and random forest have a built-in feature selection to make selecting predictor variables easier. However, the decision tree model that was constructed had a high accuracy on the training set but a relatively low accuracy on the test set. This is a direct cause of overfitting the data. To remedy this situation, the random forest model used a sampling technique called bootstrapping. The number of variables from the subset were randomly selected as candidate variables using mtry and number of trees to be constructed through ntree.  The final error rate was plotted against mtry to get the optimal value. Furthermore, it was observed that random forest had the superior performance among the four models.





