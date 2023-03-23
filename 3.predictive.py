#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd
from sklearn.linear_model import LinearRegression


# In[2]:


df = pd.read_csv("Q3_Sikka data (1).csv")


# In[3]:


oct_data = df[df['Date'].str.startswith('2022-10')]
nov_data = df[df['Date'].str.startswith('2022-11')]


# In[4]:


features = ['Installs', 'Uninstalls', 'Signups', 'DAU']
target = ['Referrals']


# In[5]:


lr = LinearRegression()
lr.fit(oct_data[features], oct_data[target])


# In[6]:


nov_data['Referrals_Predicted'] = lr.predict(nov_data[features])


# In[9]:


print(nov_data[['Date', 'Referrals_Predicted']].head(15))


# In[ ]:




