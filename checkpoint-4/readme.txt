These notebooks were created to run locally. Use pip to install the following dependencies:

pandas, numpy, matplotlib, scikit-learn, jupyterlab

Research questions: using the attributes of the search warrant table, is it possible to predict whether a search warrant will
result in an arrest? Is it possible to predict whether property will be recovered.

The first notebook shows results using two different fully connected neural network classifiers to analyze arrest patterns
in the search warrant dataset. The next notebook (Checkpoint_4_judge_names) investigates the performance of the same architecture using the
base dataset augmented with judge names. The last notebook (Checkpoint_4_approver_names) uses the base data set augmented
with pre-execution approver names instead of judge names. Full results of all 10 trials for all experiments can be viewed in the
.txt log files of the corresponding names. 

Our results can be reproduced by running the notebooks using VSCode's jupyter integration.
Note that the base dataset trials also include statistics about the permutation importance of various attributes. 
We did not repeat the permutation importance experiments on the augmented datasets due to significantly increased computational overhead.