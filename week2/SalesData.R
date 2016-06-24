#2.1.Make a plot of the distribution of prices.
ggplot(oj, aes(price)) + geom_histogram()
#2.2. Change the x-axis on this plot to use a logarithmic scale using scale_x_log10().
ggplot(oj, aes(price)) + geom_histogram() +scale_x_log10()
#2.3.Repeat i), faceted by brand.
ggplot(oj, aes(x=price)) + geom_bar() + facet_grid(. ~ brand)

#2.4.Repeat ii), faceted by brand
ggplot(oj, aes(x=price)) + geom_bar() + facet_grid(. ~ brand) + scale_x_log10()
#2.5.What do these graphs tell you about the variation in price? 
#Why do the log plots look different? Do you find them more/less informative?

tropicana is the msost expensive brand, and people seems to pay more drink when it is arount 
one dolar and two dollars.
it deponds if you looking for a general idea(we use the log) or small details(without the log).

#3.1.Plot logmove (the log of quantity sold) vs. log price
ggplot(oj, aes(log(price),logmove)) + geom_point()
#3.2. Color each point by brand. 
#What do insights can you derive that were not apparent before?
ggplot(oj, aes(log(price),logmove, color = brand)) + geom_point()
 from the graph before we have a global idea about the quantity and the price, the quantity
 go up the price go down
 from this graph we know exaclty which branch has more quantity compared with the price.
tropicana is more expensive than dominicks, that is why the quantity is less. and when the price of 
dominicks go up it seems that the quantity decrese faster. however,when tropicana
increase the price the quantity decreses slowly.
  

#4.Do a regression of logmove on log price. How well does the model fit? 
#What is the elasticity 
#(the coefficient on log price), and does it make sense?

lm.fit= lm(logmove~log(price), data=oj)
plot(oj$logmove, log(oj$price))
abline(lm.fit)

The the elasticity (the coefficient on log price) = -1.60131
#PE less than -1: Changes in price impact demand in the same direction. 
when the price go down the demand go down and when the price go down the demand go down also.




#2.Now add in an intercept term for each brand (by adding brand to the regression formula). 
#How do the results change? How should we interpret these coefficients?
lm.fit1 = lm(logmove~log(price) + brand -1, data=oj)
summary(lm.fit1)
---The is decresed more the coefficient on log price = -3.13869
---The coefficient for daninacis is not showing.
and the coefficient for tropicana is positive now and larger tha 1  Changes
in price impact demand in opposite direction.
--- for minate,main is between -1 and 1 Relatively inelastic demand.

#Now add interaction terms to allow the elasticities to differ by brand,
#by including a brand:log price term in the regression formula. 
lm.fit2 = lm(logmove~brand:log(price), data=oj)
summary(lm.fit2)
#Note the estimate coefficients will "offset" the base estimates. 
#What is the insights we get from this regression? 
dominicks 

#What is the elasticity for each firm? 
branddominicks:log(price)   -3.92032  
  brandminute.maid:log(price) -2.65843  
  brandtropicana:log(price)   -2.13001

#Do the elasticities make sense?
  
#5.Impact of "featuring in store".
  
  #Which brand is featured the most? Make a plot to show this.
  ggplot(oj, aes(feat)) + geom_histogram() + facet_grid(. ~ brand)
  oj %>% filter(feat ==1 ) %>% group_by(brand) %>% ggplot(aes(brand)) + geom_bar()
  
  #How should we incorporate the "featured in store" variable into our regression? 
  #Start with an additive formulation (e.g. feature impacts sales, but not through price).
  
  lm.fit3 = lm(logmove~brand:log(price) + feat, data=oj)
  summary(lm.fit3)
  
  (Intercept)                        feat   branddominicks:log(price) 
  10.6570513                   0.9227326                  -3.2046791 
  brandminute.maid:log(price)   brandtropicana:log(price) 
  -2.1765727                  -1.6572625 
  
  #Now run a model where features can impact sales and price sensitivity.
  lm.fit3 = lm(logmove~log(price)*feat, data=oj)
  coef(lm.fit3)
  
  #Now run a model where each brand can have a different 
  #impact of being featured and a different impact on price sensitivity. 
  #Produce a table of elasticties for each brand, 
  #one row for "featured" and one row for "not featured" (you need 6 estimates).
  
  lm.fit4 = lm(logmove~brand:log(price)*feat, data=oj)
  summary(lm.fit4)
  
  
  Coefficients:
    Estimate   
  (Intercept)                      10.53479    
    feat                              1.33948    
    branddominicks:log(price)        -2.97375    
    brandminute.maid:log(price)      -2.08461   
    brandtropicana:log(price)        -1.51291    
    branddominicks:log(price):feat   -0.96414    
    brandminute.maid:log(price):feat -0.32409    
    brandtropicana:log(price):feat   -0.73270    



    ggplot(oj, aes(x= log(price), y= logmove, color = as.factor(feat ))) 
    + geom_smooth(method="lm")+ facet_grid(~brand) + geom_point()


