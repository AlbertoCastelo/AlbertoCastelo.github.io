---
layout: post
title: Questions when Building DS products
tags: [product_development, ds]
# image: https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.rxlogix.com%2Fen%2Fdata-analysis.html&psig=AOvVaw0j2dP4SbguSt3oyraosNSA&ust=1612594710483000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJDj2M2V0u4CFQAAAAAdAAAAABAD
---

I have been building Data Science (DS) products almost for the last 3 years since I first joined Nextail Labs. Furthermore, I have been working on funded DS projects since Graduate School back in 2015. In this time I have both enjoyed and suffered the process of building products that have an impact in the world. Since I believe that DS and AI can have a huge impact in people’s lives and in our world, I want to share the most important questions that we need to ask ourselves while building DS products. The questions are divided into several categories:

* Framing the Problem
* Metrics and Iterations
* DS Friendly Platform
* DS Risk Management
* Feeling the Customer

# Framing the Problem
“A problem well defined is half solved”
* Data:
  - What is the minimum viable data? Do you expect to have it for all users/clients?
  - What data is available? 
  - Do you expect to have different users with a set of different datasets?
  - Can we enrich our data with external datasets? 
  - Can we collect data that is not being collected right now?
  - Does your technical platform support our data requirements?
* Processing: 
  - How much data does the system need to process? 
  - How often needs to be processed?
  - Is it a batch problem or a streaming process?
  - Should it run on demand or periodically?
  - Does your technical platform support our processing requirements?
* Impact:
  - Can you measure the business impact?
  - What are the consequences of making a mistake? 
  - Can mistakes be compensated? 
  - Do all the mistakes have the same impact?

# Metrics and Iterations
Business metrics are the important ones. That is, how your product is adding value to your customer so you can capture a fraction of it. 
* Business Metrics
  - What are the metrics that the customer uses?
  - Can you map a metric value to dollars?
  - How can customer metrics be hacked?
  - Are there other metrics that offer an orthogonal or complementary view to the product’s impact?
  - Does the customer know what their business metrics look like?
  - Can you define a target value?
* Proxy Metrics
  - Can you evaluate the business impact that a change in a DS subcomponent has?
  - Can you use proxy metrics to decouple the end-to-end pipeline so you can break down problems?
  - Can you define a reliable target value for proxy metrics?
* Iterating
  - What is the minimum viable model?
  - What is the ratio “business value provided” and “cost of iteration”?
  - Did you enter a region of diminishing returns?
  - Can we stop iterating?

# DS Platform
DS need to make analysis, models, deployments and monitor. Having a technical platform that allows them to work as independently as possible will have the best return.
* Data Platform
  - Do DS have easy access to the data they need (raw or derived)?
  - Can DS store data for future access?
  - Is data access safe, reliable and scalable?
  - Is time travelling allowed (specially in transactional data)?
* Compute Platform
  - Does the DS need to know about the inner details of the platform?
  - Can DS run many processes in parallel?
  - Are there hardware accelerators available (GPU, TPU, …)?
  - Can workloads be scheduled?
  - Can workloads be run based on a dependency graph (DAG)?
  - Can workloads be run based on events?
* Complementary Infrastructure
  - Can DS setup (or has support to) a dashboard to monitor important metrics?

# DS Risk Management
There are many risks around DS.
* Models
  - Does the problem have a feasible solution?
  - What are the uncertainties with the most potential impact that we have?
  - What is the task or analysis that you can do that will reduce the uncertainty that you have?
  - Can you dedicate a timebox to perform such analysis?
  - Is the model robust?
  - What are the best/mean/worst case scenarios?
* Delivering
  - Is the DS overpromising or being too optimistic?
  - Are (outside and inside) expectations calibrated with reality?
  - Is the DS communicating regularly with stakeholders outside and inside the organization?

# Feeling the Customer

Some of these questions are applicable not only in Data Science products but in any digital product. However, it is important for Data Scientist to think about them as well and how his/her work fits within the big picture.
* What customer’s pain is your product addressing? Is it important?
* How does the customer benefit from using your product? Does it save time, money, employees, complexity?
* How do they solve their problem in the absence of your product? How much time and resources do they consume? What tools do they use?
* Who do you need to convince to penetrate within the company? Is it the CEO, Middle Manager or other professionals?
* How are they going to judge your solution? What are the important dimensions in which your product has to perform well?


---
### Note
This is an ever unfinished post that I will be updating regularly when more questions or topics come to mind. I took inspiration from fantastic [Fastai’s Data project checklist](https://www.fast.ai/2020/01/07/data-questionnaire/)
