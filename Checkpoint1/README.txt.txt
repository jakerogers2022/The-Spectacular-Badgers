Checkpoint 1: SQL Analytics
Jake Rogers, Kelly Jiang, Alex Reneau

1. Can relationships be identified between geography, and likelihood of arrest?
To answer this question run the first query that starts on line 5.
This will return a table with proportions in one column and district number in the other


2. How many search warrants are executed per police unit normalized by unit size?
To answer this question run the second query starting on line 15.
This will return a table with the police unit number and its number of search warrants executed per officer in that unit

A follow up query was to see how active units are across districts. This can be seen when running the next query on line 21.
It returns a table with the min, max, and average number of districts each police unit is active in.


3. What proportion of lawsuits list unlawful search/seizure as the primary cause?
To answer this question run the next query on line 29.
This will return the total number of lawsuits in the table.

Then run the next query on line 32
This will return a table with the counts of search warrants for different reasons
From referencing this table you can just divide the count in the rows with unlawful search seizure by the total number of lawsuits


4. What fraction of TRRs are located at residences?
To answer this question run the next query on line 38
This will return the total number of TRRs

Then run the next query on line 40
This will return the number of TRRs that occur at a residence
Divide the second result by the first to get the fraction


5. What fraction of lawsuits have a location listed?
Run the next query on line 43 to get the total count of lawsuits.
Then run the next query on line 45 to get the lawsuits with a location listed
divide these results to get the answer

The last 2 queries expand slightly on this question to get the lawsuits that have an address listed and the ones that have a point listed respectivley






