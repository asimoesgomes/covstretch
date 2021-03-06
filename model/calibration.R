
library(tidyverse)
load("data/default_inputs.Rdata")

# Demographics (for comparing HIC vs LIC)
hic_pop <- pbc_spread[countries["High-income countries"],] %>% as.numeric()
lic_pop <- pbc_spread[countries["Low-income countries"],] %>% as.numeric()
ifr_hic <- c(0.002, 0.006, 0.03, 0.08, 0.15, 0.60, 2.2, 5.1, 9.3)/100
ifr_lic <- ifr_hic*(3.2/2)^(5:(-3))


#concave function
A=.95
beta=(log(0.8)- log(A))/log(.5)
Q=0.5
#harm<-ifr_hic
harm<-ifr_lic
#pop <- hic_pop/sum(hic_pop)
pop <- lic_pop/sum(lic_pop)


optimal_policy<- function(pop,harm,Q){

Q_temp<-Q

for (i in 1:length(harm)){
  x<-( Q_temp*harm[1:(length(harm)-i +1) ]^(1/(1-beta)) / sum(pop[1:(length(harm)-i +1)]*harm[1:(length(harm)-i +1)]^(1/(1-beta)) ) )
  #print(x)
  i_star<-i
  if( max( A*x^beta) <0.95 ) {
    
    break
  }
  Q_temp<-Q_temp-pop[(length(harm)-i +1)]
}
x_temp<-x
for (i in 1:(length(harm)-i_star+ 1)){
  x<-( Q_temp*harm[i:(length(harm)-i_star+ 1) ]^(1/(1-beta)) / sum(pop[i:(length(harm)-i_star+ 1)]*harm[i:(length(harm)-i_star+ 1)]^(1/(1-beta)) ) )
  #print(x)
  i_min<-i
  if( min( A*x^beta) >0.5 ) {
    break
  }
}

x_star<- c( rep(0,i_min-1),x,rep(1,i_star-1))
if (i_star==9){x_star<-c(x_temp,rep(1,i_star-1))}
return(x_star)
#A*x_star^beta
}

hic_results<-data_frame(
  "Age Group" = c("0-10","10-20","20-30","30-40","40-50","50-60","60-70","70-80","90+"),
  "Population Share" = hic_pop/sum(hic_pop),
  "1.0"= optimal_policy(hic_pop/sum(hic_pop),ifr_hic,1.0),
  "0.9"= optimal_policy(hic_pop/sum(hic_pop),ifr_hic,0.9),
  "0.8"= optimal_policy(hic_pop/sum(hic_pop),ifr_hic,0.8),
  "0.7"= optimal_policy(hic_pop/sum(hic_pop),ifr_hic,0.7),
  "0.6"= optimal_policy(hic_pop/sum(hic_pop),ifr_hic,0.6),
  "0.5"= optimal_policy(hic_pop/sum(hic_pop),ifr_hic,0.5),
  "0.4"= optimal_policy(hic_pop/sum(hic_pop),ifr_hic,0.4),
  "0.3"= optimal_policy(hic_pop/sum(hic_pop),ifr_hic,0.3),
  "0.2"= optimal_policy(hic_pop/sum(hic_pop),ifr_hic,0.2),
  "0.1"= optimal_policy(hic_pop/sum(hic_pop),ifr_hic,0.1))

lic_results<-data_frame(
  "Age Group" = c("0-10","10-20","20-30","30-40","40-50","50-60","60-70","70-80","90+"),
  "Population Share" = lic_pop/sum(lic_pop),
  "1.0"= optimal_policy(lic_pop/sum(lic_pop),ifr_lic,1.0),
  "0.9"= optimal_policy(lic_pop/sum(lic_pop),ifr_lic,0.9),
  "0.8"= optimal_policy(lic_pop/sum(lic_pop),ifr_lic,0.8),
  "0.7"= optimal_policy(lic_pop/sum(lic_pop),ifr_lic,0.7),
  "0.6"= optimal_policy(lic_pop/sum(lic_pop),ifr_lic,0.6),
  "0.5"= optimal_policy(lic_pop/sum(lic_pop),ifr_lic,0.5),
  "0.4"= optimal_policy(lic_pop/sum(lic_pop),ifr_lic,0.4),
  "0.3"= optimal_policy(lic_pop/sum(lic_pop),ifr_lic,0.3),
  "0.2"= optimal_policy(lic_pop/sum(lic_pop),ifr_lic,0.2),
  "0.1"= optimal_policy(lic_pop/sum(lic_pop),ifr_lic,0.1))


