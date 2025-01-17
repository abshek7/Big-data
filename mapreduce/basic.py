# Google MapReduce: Simplified Data Processing on Large Clusters
# https://static.googleusercontent.com/media/research.google.com/en//archive/mapreduce-osdi04.pdf



from collections import defaultdict
dataset = [
    "MapReduce is a programming model",
    "MapReduce simplifies processing large datasets",
    "In MapReduce, the tasks are divided into map and reduce",
    "MapReduce is used for parallel processing"
]

# Step 1: Map function
def map_function(sentence):
    print(f"Processing sentence: '{sentence}'")
    word_count = [] 
    for word in sentence.split():
        word = word.lower().strip(",.?!")  # Normalize the word (lowercase and remove punctuation),stemming and lemmatization can be added
        word_count.append((word, 1))  # Each word contributes 1 count
        #like here even the word is repeated in the sentence, it will be counted as 1 and 1 not 2 directly with key-value pair
    print(f"Mapped word count for sentence: {word_count}")
    return word_count

# Step 2: Reduce function
def reduce_function(mapped_data):
    print("\nReducing data:")
    reduced_data = defaultdict(int)
    for word, count in mapped_data:
        reduced_data[word] += count   
        print(f"Word: '{word}' - Count: {reduced_data[word]}")   
    print(f"\nFinal reduced data (word frequencies): {reduced_data}")
    return reduced_data

# Step 3: Execute MapReduce
def map_reduce(dataset):
    print("\nStarting MapReduce...\n") 
    mapped_data = []
    for sentence in dataset:
        print(f"\nApplying map function to sentence: '{sentence}'")
        mapped_result = map_function(sentence)  # Get the mapped result for each sentence
        mapped_data.extend(mapped_result)  # Flatten the list of results
        print(f"Intermediate mapped data: {mapped_data}")
    
    # Apply the reduce function to the mapped data
    print("\nApplying reduce function to mapped data...")
    reduced_data = reduce_function(mapped_data)
    
    return reduced_data
 
result = map_reduce(dataset)
 
print("\nFinal reduced result (word frequencies):")
print(result)
