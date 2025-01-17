import ray
from collections import defaultdict
from datasets import load_dataset

# start 
ray.init(ignore_reinit_error=True)

dataset = load_dataset("ag_news", split="train[:7]")

# Define Ray remote functions for parallel processing
@ray.remote
def map_function(sentence):
    word_count = []
    for word in sentence.split():
        word = word.lower().strip(",.#*-?!")
        word_count.append((word, 1))
    return word_count

@ray.remote
def reduce_function(mapped_data):
    reduced_data = defaultdict(int)
    for word, count in mapped_data:
        reduced_data[word] += count
    return reduced_data

# Parallel MapReduce function using Ray
def parallel_map_reduce_ray(dataset):
    # Step 1: Parallel Map Phase
    mapped_futures = [map_function.remote(sentence) for sentence in dataset['text']]
    mapped_data = ray.get(mapped_futures)   

     
    all_mapped_data = [item for sublist in mapped_data for item in sublist]

    # Step 2: Parallel Reduce Phase
    reduced_result = ray.get(reduce_function.remote(all_mapped_data))
    return reduced_result

result = parallel_map_reduce_ray(dataset)

print("\nFinal reduced result (word frequencies):")
print(result)

ray.shutdown()
