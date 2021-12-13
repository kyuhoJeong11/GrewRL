
from rllab.baselines.linear_feature_baseline import LinearFeatureBaseline
from rllab.baselines.gaussian_mlp_baseline import GaussianMLPBaseline
from rllab.envs.mujoco.ant_env_fixleg import AntEnvFixedLeg
from rllab.envs.normalized_env import normalize
from rllab.misc.instrument import stub, run_experiment_lite
from sandbox.rocky.tf.algos.trpo import TRPO
from sandbox.rocky.tf.policies.gaussian_mlp_policy import GaussianMLPPolicy
from sandbox.rocky.tf.envs.base import TfEnv

import tensorflow as tf

stub(globals())

from rllab.misc.instrument import VariantGenerator, variant


class VG(VariantGenerator):

    @variant
    def fast_lr(self):
        return [0.1]

    @variant
    def meta_step_size(self):
        return [0.01] # sometimes 0.02 better

    @variant
    def fast_batch_size(self):
        return [4000]


    @variant
    def seed(self):
        return [1]

    @variant
    def task_var(self):  # fwd/bwd task or goal vel task
        # 0 for fwd/bwd, 1 for goal vel (kind of), 2 for goal pose
        return [1]


# should also code up alternative KL thing

variants = VG().variants()

max_path_length = 200
num_grad_updates = 1
use_maml=False

for v in variants:
    
    env = TfEnv(normalize(AntEnvFixedLeg()))
    task_var = 'randleg'
    policy = GaussianMLPPolicy(
        name="policy",
        env_spec=env.spec,
        hidden_sizes=(100,100),
    )

    baseline = LinearFeatureBaseline(env_spec=env.spec)
    algo = TRPO(
        env=env,
        policy=policy,
        #load_policy='/home/user/Documents/maml_rl/data/local/posticml-trpo-ant3-randleg-200/leg1.0_fbs4000_flr_0.1_mlr0.01/itr_2000.pkl',
        baseline=baseline,
        batch_size=v['fast_batch_size'], # number of trajs for grad update
        max_path_length=max_path_length,
        num_grad_updates=num_grad_updates,
        n_itr=2001,
        discount=0.99,
        step_size=v['meta_step_size'],
        plot=False,
    )

    run_experiment_lite(
        algo.train(),
        exp_prefix='posticml_trpo_test_' + task_var + '_' + str(max_path_length),
        exp_name='leg1.0'+'_fbs'+str(v['fast_batch_size'])+'_flr_' + str(v['fast_lr'])  + '_mlr' + str(v['meta_step_size']),
        # Number of parallel workers for sampling
        n_parallel=8,
        # Only keep the snapshot parameters for the last iteration
        snapshot_mode="gap",
        snapshot_gap=100,
        sync_s3_pkl=True,
        # Specifies the seed for the experiment. If this is not provided, a random seed
        # will be used
        seed=v["seed"],
        mode="local",
        #mode="ec2",
        variant=v,
        # plot=True,
        # terminate_machine=False,
    )
