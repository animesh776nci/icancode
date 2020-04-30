# -*- coding: utf-8 -*-
"""
Created on Tue Sep 24 22:40:57 2019

@author: anime
""

name = input("enter name of student \n")
score = input("enter the total score \n")

for student in range(1,4):
        print(name , score)
        
        
"""
import operator

def readNameDetails():
    print("Enter the number of students :  ")
    noOfStudent= int(input())
    studentRecord={}
    for student in range(0,noOfStudent):
        print("Enter the name of student:  ")
        name = input()
        print("Enter the marks of student:  ")
        marks = int(input())
        studentRecord[name] = marks  
    return studentRecord

studentRecord = readNameDetails()
    
def rankStudent(studentRecord):
    
    
    
def cashReward():
    
    
def appreciation():
"""