from datasets import load_dataset
from collections import defaultdict
#The AG News contains 30,000 training and 1,900 test samples per class. The dataset has four classes: World, Sports, Business, and Sci/Tech

#We will use the first 7(thala for a reason )  
dataset = load_dataset("ag_news", split="train[:7]")

def map_function(sentence):
    print(f"\nProcessing sentence: '{sentence}'")
    word_count = [] 
    for word in sentence.split():
        word = word.lower().strip(",.#*-?!")
        word_count.append((word, 1))  
    print(f"Mapped word count for sentence: {word_count}")
    return word_count

def reduce_function(mapped_data):
    print("\nReducing data:")
    reduced_data = defaultdict(int)
    for word, count in mapped_data:
        print(f"Adding {count} to {word}, current count: {reduced_data[word]}")
        reduced_data[word] += count  
    print(f"Reduced data (final counts): {reduced_data}")
    return reduced_data

def map_reduce(dataset):
    print("\nStarting MapReduce...")

    mapped_data = []
    for sentence in dataset['text']:
        mapped_result = map_function(sentence)  
        mapped_data.extend(mapped_result)  
        print(f"Intermediate mapped data so far: {mapped_data}")
    
    reduced_data = reduce_function(mapped_data)
    
    return reduced_data

result = map_reduce(dataset)

print("\nFinal reduced result (word frequencies):")
print(result)
