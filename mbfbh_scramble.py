#!/usr/bin/env python3
import string, random, re, sys
# python3.x
def scramble(unscrambled):
    ''' 
    Scrambles the word(s) in unscrambled such that the first and last letter remain the same,
    but the inner letters are scrambled. Preserves the punctuation.
    See also: http://science.slashdot.org/story/03/09/15/2227256/can-you-raed-tihs
    '''
    
    splitter = re.compile(r'\s')
    words = splitter.split(u''.join(ch for ch in unscrambled if ch not in set(string.punctuation)))
    for word in words:
        len_ = len(word)
        if len_ < 4: continue
        if len_ == 4:
            scrambled = u'%c%c%c%c' % (word[0], word[2], word[1], word[3])
        else:
            mid = list(word[1:-1])
            random.shuffle(mid)
            scrambled = u'%c%s%c' % (word[0], ''.join(mid), word[-1])
        unscrambled = unscrambled.replace(word, scrambled, 1)
    
    return unscrambled
    
def convert(): 
        input_file = open('scramblel.txt', 'r')
        st=input_file.readline()
        output_file = open('scramble.txt', 'w')
        st = scramble(st)
        output_file.write(st)
        input_file.close()
        output_file.close()

if __name__ == '__main__':
    convert()
