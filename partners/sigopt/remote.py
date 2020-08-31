
from sigopt import Connection
from sigopt.examples import franke_function
import os
import time

experiment_id = os.getenv('EXP_ID')

# Evaluate your model with the suggested parameter assignments
# Franke function - http://www.sfu.ca/~ssurjano/franke2d.html
def evaluate_model(assignments):
  return franke_function(assignments['x'], assignments['y'])

# plug in your SigOpt client token here
conn = Connection(client_token=<your-token>)

time.sleep(60)

suggestion = conn.experiments(experiment_id).suggestions().create()

value = evaluate_model(suggestion.assignments)

conn.experiments(experiment_id).observations().create(
  suggestion=suggestion.id,
  value=value,
  )  
