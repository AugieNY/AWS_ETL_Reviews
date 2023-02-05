
-- Create table to filter helpful reviews and format votes columns.
CREATE TABLE helpful_review AS
SELECT
review_id,
star_rating,
CAST(helpful_votes as FLOAT) as helpful_votes,
CAST(total_votes as FLOAT) as total_votes,
CAST(helpful_votes as FLOAT)/CAST(total_votes as FLOAT) *100 as "helpful_votes_%",
vine,
verified_purchase

FROM vine_table
WHERE CAST(helpful_votes as FLOAT) >=20



CREATE TABLE reviews_majorly_helpful AS 
SELECT * FROM helpful_review
WHERE "helpful_votes_%">= 50;

SELECT * FROM reviews_majorly_helpful;

-- Create paid reviews table
CREATE TABLE reviews_paid AS 
SELECT
* FROM reviews_majorly_helpful
WHERE vine = 'Y';

-- Create unpaid reviews table
CREATE TABLE reviews_unpaid AS 
SELECT
* FROM reviews_majorly_helpful
WHERE vine = 'N';

-- Create a main table with product name and reviews in order to create aggregates.

CREATE TABLE products_reviews AS
SELECT
rw.review_id as "review_id",
p.product_title as "Product sold",
CAST(rw.star_rating as FLOAT) as "Star rating",
rw.helpful_votes as "helpful votes",
rw.total_votes as "total votes",
rw."helpful_votes_%" as "Helpful_votes_%",
CASE WHEN rw.vine = 'Y' THEN 'Yes'
WHEN rw.vine = 'N' THEN 'No'
ELSE null
END as "Vine_program",
CASE WHEN verified_purchase='Y' THEN 'Verified'
ELSE 'No' END as "Verified purchase?"

FROM reviews_majorly_helpful as "rw"
LEFT JOIN review_id_table ON review_id_table.review_id = rw.review_id
LEFT JOIN products_table as "p" ON p.product_id = review_id_table.product_id;

SELECT * FROM products_reviews

-- Create aggregates of number of reviews, 5 star reviews, % of 5 star reviews for paid and unpaid reviews for each products

CREATE TABLE "summary_reviews_products" AS
SELECT DISTINCT
"Product sold",
COUNT(review_id) as "Nb of reviews",
SUM("total votes") as "Total Votes",
SUM("helpful votes") as "Helpful votes",
SUM(CASE WHEN "Star rating" = 5 THEN 1 ELSE 0 END) as "Nb of 5 star reviews",
(SUM(CASE WHEN "Star rating" = 5 THEN 1 ELSE 0 END)/COUNT(review_id))*100 as "% of 5 star review",
SUM(CASE WHEN "Star rating" = 5 AND "Vine_program" = 'Yes' THEN 1 ELSE 0 END) as "5 star reviews paid",
SUM(CASE WHEN "Star rating" = 5 AND "Vine_program" = 'No' THEN 1 ELSE 0 END) as "5 star reviews unpaid",
SUM(CASE WHEN "Star rating" = 5 AND "Vine_program" = 'Yes' AND "Verified purchase?" = 'Verified' THEN 1 ELSE 0 END) as "5 star reviews paid on verified purchase"
FROM products_reviews
GROUP BY "Product sold" ORDER BY SUM(CASE WHEN "Star rating" = 5 THEN 1 ELSE 0 END) DESC


SELECT * FROM "summary_reviews_products"

-- Aggregates only
CREATE TABLE reviews_aggregates AS
SELECT
sum("Nb of reviews") as "Nb of reviews",
sum("Total Votes") as "Total Votes",
sum("Helpful votes") as "Helpful votes",
sum("Nb of 5 star reviews") as "5 star reviews",
avg("% of 5 star review") as "% of 5 star review",
sum("5 star reviews paid") as "5 star reviews paid",
sum("5 star reviews unpaid") as "5 star reviews unpaid",
sum("5 star reviews paid on verified purchase") as "5 star reviews paid on verified purchase",
sum("5 star reviews paid")/sum("Nb of reviews") as "% 5 star reviews"
 FROM "summary_reviews_products"
 
SELECT * FROM "reviews_aggregates"