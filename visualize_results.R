#R script to visualize results from BIMAS project 
#by Hope Townsend and Kaylee Rosenberger 

library(ggplot2)
library(dplyr)
library(gridExtra)
library(grid)
theme_set(theme_bw())

setwd("C:/Users/kayle/Documents/Courses/Multi-agent systems/Project") 
#import data
dat = read.csv("final_model experiment-spreadsheet.csv")
#View(dat)

#row 17 contains # individuals dead / resistant (dead in even cols and resistant in odd)
#num_vectors = row 7 
#avg_node_degree = row 9
#resistance_decay_chance = row 12 

##################################################################
#Data processing 

#just saving the # of dead individuals -- other info is redundant since they are either dead or alive and we know the total 
col_even = seq_len(ncol(dat)) %% 2              # Create row indicator
dat_dead = dat[, col_even == 0]            # Subset even rows
dat_dead = as.data.frame(dat_dead)

#Create a new dataframe for easier plotting
sim = seq(1, 1050, 1)
num_dead = as.vector(as.numeric(dat_dead[17,]))
num_vectors = as.vector(as.numeric(dat_dead[7,]))
avg_node_degree = as.vector(as.numeric(dat_dead[9,]))
resistance_decay_chance = as.vector(as.numeric(dat_dead[12,]))

data_processed = data.frame(sim = sim, num_dead = num_dead, num_vectors = num_vectors, avg_node_degree = avg_node_degree, res_decay_chance = resistance_decay_chance)

##################################################################
#Impact of number of vectors on persistence 

#have to keep some variables constant to determine the relationships
#Each plot below shows the results faceted by avg. node degree
#and the separate plots show results for different resistance decay chances
p1 = data_processed %>% filter(res_decay_chance == 0) %>%
  ggplot() +
    geom_point(aes(x=num_vectors, y=(num_dead/70), color=as.factor(avg_node_degree))) +
    geom_line(aes(x=num_vectors, y=(num_dead/70), color=as.factor(avg_node_degree))) +
    ylim(0,1) +
    ggtitle("0% res. decay") +
    ylab("proportion dead") +
    xlab("number of vectors") +
    guides(color=guide_legend(title="avg. node degree"))
#facet_wrap(vars(avg_node_degree)) + 

p2 = data_processed %>% filter(res_decay_chance == 5) %>%
  ggplot() +
  geom_point(aes(x=num_vectors, y=(num_dead/70), color=as.factor(avg_node_degree))) +
  geom_line(aes(x=num_vectors, y=(num_dead/70), color=as.factor(avg_node_degree))) +
  ylim(0,1) +
  ggtitle("5% res. decay") +
  ylab("proportion dead") +
  xlab("number of vectors") +
  guides(color=guide_legend(title="avg. node degree"))

p3 = data_processed %>% filter(res_decay_chance == 10) %>%
  ggplot() +
  geom_point(aes(x=num_vectors, y=(num_dead/70), color=as.factor(avg_node_degree))) +
  geom_line(aes(x=num_vectors, y=(num_dead/70), color=as.factor(avg_node_degree))) +
  ylim(0,1) +
  ggtitle("10% res. decay") +
  ylab("proportion dead") +
  xlab("number of vectors") +
  guides(color=guide_legend(title="avg. node degree"))

p4 = data_processed %>% filter(res_decay_chance == 20) %>%
  ggplot() +
  geom_point(aes(x=num_vectors, y=(num_dead/70), color=as.factor(avg_node_degree))) +
  geom_line(aes(x=num_vectors, y=(num_dead/70), color=as.factor(avg_node_degree))) +
  ylim(0,1) +
  ggtitle("20% res. decay") +
  ylab("proportion dead") +
  xlab("number of vectors") +
  guides(color=guide_legend(title="avg. node degree"))

p5 = data_processed %>% filter(res_decay_chance == 30) %>%
  ggplot() +
  geom_point(aes(x=num_vectors, y=(num_dead/70), color=as.factor(avg_node_degree))) +
  geom_line(aes(x=num_vectors, y=(num_dead/70), color=as.factor(avg_node_degree))) +
  ylim(0,1) +
  ggtitle("30% res. decay") +
  ylab("proportion dead") +
  xlab("number of vectors") +
  guides(color=guide_legend(title="avg. node degree"))

p6 =data_processed %>% filter(res_decay_chance == 50) %>%
  ggplot() +
  geom_point(aes(x=num_vectors, y=(num_dead/70), color=as.factor(avg_node_degree))) +
  geom_line(aes(x=num_vectors, y=(num_dead/70), color=as.factor(avg_node_degree))) +
  ylim(0,1) +
  ggtitle("50% res. decay") +
  ylab("proportion dead") +
  xlab("number of vectors") +
  guides(color=guide_legend(title="avg. node degree"))

grid.arrange(p1, p2, p3, p4, p5, p6, top = textGrob("Population persistence",gp=gpar(fontsize=20)))
