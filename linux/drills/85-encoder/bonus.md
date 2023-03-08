# Encoding and Decoding Messages with Huffman Encoding using Pen and Paper

In this drill, you will learn how to encode and decode messages using Huffman Encoding with pen and paper. Huffman Encoding is a lossless data compression algorithm that can be used to reduce the size of your message. This method can be useful in situations where you don't have access to a computer or other digital devices.

## Introduction

In this guide, you will learn how to encode and decode messages using Huffman Encoding with pen and paper. Huffman Encoding is a lossless data compression algorithm that can be used to reduce the size of your message. This method can be useful in situations where you don't have access to a computer or other digital devices.

## Materials Needed

* Pen or pencil
* Paper

## Huffman Encoding a Message

1. Write your message on a piece of paper.
2. Count the frequency of each character in the message.
3. Create a table listing each character, its frequency, and its Huffman code.
4. Build a Huffman tree using the frequency table.
5. Assign Huffman codes to each character in the tree, with 0 for left branches and 1 for right branches.
6. Write down the Huffman-encoded message using the assigned Huffman codes.

## Decoding a Huffman-Encoded Message

1. Obtain the Huffman-encoded message and the Huffman tree or frequency table from your friend.
2. Write down the Huffman-encoded message on a piece of paper.
3. Traverse the Huffman tree from the root to the leaf node for each code in the Huffman-encoded message.
4. Write down the character corresponding to the leaf node for each code.
5. Read the decoded message.

## Example

Suppose you want to Huffman-encode the message "Hello, world!". First, count the frequency of each character:

```bash
H: 1
e: 1
l: 3
o: 2
,: 1
 : 1
w: 1
r: 1
d: 1
!: 1
```

Then, build a Huffman tree using the frequency table and assign Huffman codes to each character:

```bash
     _________
    /         \
   11         10
   / \        / \
  l   ______  o  01
     /      \
    5        6
   / \      / \
  o   H    e   00
             / \
            l   r
               / \
              d   !
```

Finally, write down the Huffman-encoded message using the assigned Huffman codes:

```bash
1101011010001100001000010101011011101110110
```

To decode the message, traverse the Huffman tree from the root to the leaf node for each code in the Huffman-encoded message:

```bash
1: move to the right child, go to node 10
1: move to the right child, go to node 01
0: move to the left child, go to node e
1: move to the right child, go to node 10
0: move to the left child, go to node l
1: move to the right child, go to node 01
1: move to the right child, go to node o
1: move to the right child, go to node 10
0: move to the left child, go to node l
0: move to the left child, go to node l
1: move to the right child, go to node o
0: move to the left child, go to node H
1: move to the right child, go to node 11
1: move to the right child, go to node 01
0: move to the left child, go to node r
1: move to the right child, go to node 10
1: move to the right child, go to node 01
0: move to the left child, go to node d
0: move to the left child, go to node !
```

* Write down the character corresponding to the leaf node for each code:

```bash
1101011010001100001000010101011011101110110
        H   e     l   l   o   ,       w   o   r   l   d   !
```

* Read the decoded message:

```bash
Hello, world!
```

## Conclusion

Huffman Encoding is a powerful tool for compressing data and reducing the size of messages. Using pen and paper, you can encode and decode Huffman-encoded messages without the need for a computer or other digital devices. With a little practice, you can become proficient in this method and use it to securely communicate with your friends.
