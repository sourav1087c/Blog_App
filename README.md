# README
1.  As I was joining on 7th lot of time went on travel and finding accomodation so I have implemented Lev1 ,Lev 2, lev 3(expect Recommended posts - same question as before
), was not able to integrate stripe but added function so that it can be integrated latter.


2. revenue algorithm which I implemented for user cut after platform deduction--
Calculate Paid Views: For each post, the method calculates the number of paid views. This is done by subtracting the number of free views from the total views. Each user gets one free view per day (free_views = 1). If the total views is greater than the number of free views, the remainder is considered as paid views. If not, the number of paid views is set to 0.
Determine Price per View: Depending on the subscription plan of the post's user, the price per view is determined.Calculate Post Revenue: The revenue for the current post is calculated by multiplying the number of paid views with the price per view.
Accumulate Total Revenue: The revenue from the current post is added to the total_revenue.
Apply Platform's Cut: After calculating the total revenue for all posts, the platform's cut is applied. The platform takes 30% of the total revenue. The remaining 70% (total_revenue * 0.7) is the revenue after the platform's cut.
Return Revenue: The method finally returns the revenue after the platform's cut.

3. Reading time algorithm--To calculate the reading time of an article, approach is to determine the number of words and then divide that by an average reading speed. The average reading speed for adults is commonly accepted as around 200-250 words per minute. using the above algo reading time for each post is calculated
