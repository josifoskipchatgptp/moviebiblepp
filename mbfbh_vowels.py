#!/usr/bin/env python3.5

import codecs

vowels = ('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U', 'а', 'е', 'и', 'о', 'у', 'А', 'Е', 'И', 'О', 'У', 'è')

def removevowels(s):
    # return ''.join([x for x in s if x not in vowels])
    return ''.join([x if x not in vowels else '-' for x in s ] )
    
def convert(): 
        input_file = open('scramblel.txt', 'r')
        st=input_file.readline()
        output_file = open('scramble.txt', 'w')
        st = removevowels(st)
        output_file.write(st)
        input_file.close()
        output_file.close()

if __name__ == '__main__':
    convert()
