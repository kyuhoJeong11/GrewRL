use_tf = True


if use_tf:
    from sandbox.rocky.tf.algos.trpo import TRPO
    from sandbox.rocky.tf.policies.gaussian_mlp_policy import GaussianMLPPolicy
    from sandbox.rocky.tf.envs.base import TfEnv
else:
    from rllab.algos.trpo import TRPO
    from rllab.policies.gaussian_mlp_policy import GaussianMLPPolicy
from rllab.baselines.linear_feature_baseline import LinearFeatureBaseline
from rllab.envs.gym_env import GymEnv
from rllab.envs.normalized_env import normalize
from rllab.misc.instrument import stub, run_experiment_lite

import sys
sys.path.append("../scripts")
from scripts.run_experiment_lite import run_experiment

import base64
import pickle as pickle

stub(globals())

env = normalize(GymEnv("Pendulum-v0"))
#env = normalize(GymEnv("Walker2d-v2"))

if use_tf:
    env = TfEnv(env)
    policy = GaussianMLPPolicy(
        name='policy',
        env_spec=env.spec,
        # The neural network policy should have two hidden layers, each with 32 hidden units.
        hidden_sizes=(32, 32)
    )
else:
    policy = GaussianMLPPolicy(
        env_spec=env.spec,
        # The neural network policy should have two hidden layers, each with 32 hidden units.
        hidden_sizes=(32, 32)
    )

baseline = LinearFeatureBaseline(env_spec=env.spec)

algo = TRPO(
    env=env,
    policy=policy,
    baseline=baseline,
    batch_size=4000,
    max_path_length=env.horizon,
    n_itr=10000,
    discount=0.99,
    step_size=0.01,
    force_batch_sampler=True,  # for TF
    # Uncomment both lines (this and the plot parameter below) to enable plotting
    #plot=True,
)

exp_name = "experiment_2020_09_03_21_30_47_0001"
dict = [
    "c:\\users\\kimtaewoo\\documents\\projects\\rllab-master\\scripts\\run_experiment_lite.py",
    "--n_parallel", "1",
    "--snapshot_mode", "last",
    "--seed", "1",
    "--exp_name", exp_name,
    "--log_dir" , "c:\\users\\kimtaewoo\\documents\\projects\\rllab-master\\data\\local\\experiment\\" + exp_name,
    "--use_cloudpickle", "False",
    "--args_data", base64.b64encode(pickle.dumps(algo.train())).decode("utf-8")
    ]
    
run_experiment(dict)

'''
run_experiment_lite(
    algo.train(),
    # Number of parallel workers for sampling
    n_parallel=1,
    # Only keep the snapshot parameters for the last iteration
    snapshot_mode="last",
    # Specifies the seed for the experiment. If this is not provided, a random seed
    # will be used
    seed=1,
    #plot=True,
)
'''