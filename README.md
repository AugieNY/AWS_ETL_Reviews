# AWS_ETL_Reviews

## Resume and Objectives
 The Amazon Vine program is a service that allows manufacturers and publishers to receive reviews for their products. We were requested by SellBy, one of the company who is paid by Amazon for the Vine program.
We will be analyzing Amazon reviews, including those written by members of the paid Amazon Vine program

## Analysis
We have picked a product, watches, to narrow down the analysis of review.
From there we used PySpark to perform ETL process to extract, transform, connect (to RDS), and load the data into PgAdmin.
Once the clean and data was organized in PgAdmin, we used SQL to determine if there is any bias toward favorable reviews from Vine Members (paid reviews).

### Number of reviews
We initially grouped the results by product name but the dataset is very wide and it wasn't enough to narrow down an analysis. We could only observe that for the top products (in number of nb of 5 star ratings), most of these reviews were unpaid (not part of the Vine Program).
![image](https://user-images.githubusercontent.com/75656368/216854576-ce734682-0b0e-48be-b4ad-c81e8f3a2cc7.png)

### 5 star reviews
Once we grouped all reviews (not anymore by product), we could see that our observation got confirmed since none of the 5star reviews were coming from the Vine Program.
![image](https://user-images.githubusercontent.com/75656368/216855012-a578a328-214b-40be-9174-eea25d3f779f.png)

### Is there a bias?
Based on our 2 previous points, we can say that there isn't bias. If there was we could have expected that most 5 star reviews were coming from the Vine period. 
One variable that wasn't required in the analysis is the verified paid purchase. Apart from the Vine Program, it would be interesting to see if the 5 star reviews are all from verified purchases.

## Recommendations & furthermore
There were a lot of data in the dataset that could have been used to go further in our analysis;
- Verified purchase
- Vine program reviews by product brand. It would be interesting to see if there is a correlation in 5 star reviews paid for each brand. Would the bias be more accentuated?
