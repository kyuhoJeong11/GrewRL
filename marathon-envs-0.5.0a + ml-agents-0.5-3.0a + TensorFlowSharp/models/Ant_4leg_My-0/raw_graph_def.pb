
C
global_step/initial_valueConst*
value	B : *
dtype0
W
global_step
VariableV2*
dtype0*
shared_name *
shape: *
	container 
?
global_step/AssignAssignglobal_stepglobal_step/initial_value*
T0*
use_locking(*
validate_shape(*
_class
loc:@global_step
R
global_step/readIdentityglobal_step*
T0*
_class
loc:@global_step
/
Add/yConst*
value	B :*
dtype0
,
AddAddglobal_step/readAdd/y*
T0
t
AssignAssignglobal_stepAdd*
T0*
use_locking(*
validate_shape(*
_class
loc:@global_step
5

batch_sizePlaceholder*
dtype0*
shape:
:
sequence_lengthPlaceholder*
dtype0*
shape:
;
masksPlaceholder*
dtype0*
shape:?????????
+
CastCastmasks*

DstT0*

SrcT0
F
last_reward/initial_valueConst*
valueB
 *    *
dtype0
W
last_reward
VariableV2*
dtype0*
shared_name *
shape: *
	container 
?
last_reward/AssignAssignlast_rewardlast_reward/initial_value*
T0*
use_locking(*
validate_shape(*
_class
loc:@last_reward
R
last_reward/readIdentitylast_reward*
T0*
_class
loc:@last_reward
3

new_rewardPlaceholder*
dtype0*
shape: 
}
Assign_1Assignlast_reward
new_reward*
T0*
use_locking(*
validate_shape(*
_class
loc:@last_reward
L
vector_observationPlaceholder*
dtype0*
shape:?????????1
}
.running_mean/Initializer/zeros/shape_as_tensorConst*
valueB:1*
dtype0*
_class
loc:@running_mean
r
$running_mean/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*
_class
loc:@running_mean
?
running_mean/Initializer/zerosFill.running_mean/Initializer/zeros/shape_as_tensor$running_mean/Initializer/zeros/Const*
T0*

index_type0*
_class
loc:@running_mean
}
running_mean
VariableV2*
dtype0*
shared_name *
shape:1*
	container *
_class
loc:@running_mean
?
running_mean/AssignAssignrunning_meanrunning_mean/Initializer/zeros*
T0*
use_locking(*
validate_shape(*
_class
loc:@running_mean
U
running_mean/readIdentityrunning_mean*
T0*
_class
loc:@running_mean
?
1running_variance/Initializer/ones/shape_as_tensorConst*
valueB:1*
dtype0*#
_class
loc:@running_variance
y
'running_variance/Initializer/ones/ConstConst*
valueB
 *  ??*
dtype0*#
_class
loc:@running_variance
?
!running_variance/Initializer/onesFill1running_variance/Initializer/ones/shape_as_tensor'running_variance/Initializer/ones/Const*
T0*

index_type0*#
_class
loc:@running_variance
?
running_variance
VariableV2*
dtype0*
shared_name *
shape:1*
	container *#
_class
loc:@running_variance
?
running_variance/AssignAssignrunning_variance!running_variance/Initializer/ones*
T0*
use_locking(*
validate_shape(*#
_class
loc:@running_variance
a
running_variance/readIdentityrunning_variance*
T0*#
_class
loc:@running_variance
@
Mean/reduction_indicesConst*
value	B : *
dtype0
^
MeanMeanvector_observationMean/reduction_indices*
	keep_dims( *
T0*

Tidx0
,
subSubMeanrunning_mean/read*
T0
1
Add_1/yConst*
value	B :*
dtype0
0
Add_1Addglobal_step/readAdd_1/y*
T0
-
Cast_1CastAdd_1*

DstT0*

SrcT0
(
truedivRealDivsubCast_1*
T0
/
addAddrunning_mean/readtruediv*
T0
 
sub_1SubMeanadd*
T0
.
sub_2SubMeanrunning_mean/read*
T0
!
mulMulsub_1sub_2*
T0
1
add_1Addrunning_variance/readmul*
T0
x
Assign_2Assignrunning_meanadd*
T0*
use_locking(*
validate_shape(*
_class
loc:@running_mean
?
Assign_3Assignrunning_varianceadd_1*
T0*
use_locking(*
validate_shape(*#
_class
loc:@running_variance
<
sub_3Subvector_observationrunning_mean/read*
T0
8
Cast_2Castglobal_step/read*

DstT0*

SrcT0
4
add_2/yConst*
valueB
 *  ??*
dtype0
&
add_2AddCast_2add_2/y*
T0
;
	truediv_1RealDivrunning_variance/readadd_2*
T0
 
SqrtSqrt	truediv_1*
T0
*
	truediv_2RealDivsub_3Sqrt*
T0
G
normalized_state/Minimum/yConst*
valueB
 *  ?@*
dtype0
S
normalized_state/MinimumMinimum	truediv_2normalized_state/Minimum/y*
T0
?
normalized_state/yConst*
valueB
 *  ??*
dtype0
R
normalized_stateMaximumnormalized_state/Minimumnormalized_state/y*
T0
?
?main_graph_0/hidden_0/kernel/Initializer/truncated_normal/shapeConst*
valueB"1   5   *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
>main_graph_0/hidden_0/kernel/Initializer/truncated_normal/meanConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
@main_graph_0/hidden_0/kernel/Initializer/truncated_normal/stddevConst*
valueB
 *??&>*
dtype0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
Imain_graph_0/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormal?main_graph_0/hidden_0/kernel/Initializer/truncated_normal/shape*
T0*
dtype0*
seed2:*/
_class%
#!loc:@main_graph_0/hidden_0/kernel*
seed?
?
=main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mulMulImain_graph_0/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormal@main_graph_0/hidden_0/kernel/Initializer/truncated_normal/stddev*
T0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
9main_graph_0/hidden_0/kernel/Initializer/truncated_normalAdd=main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mul>main_graph_0/hidden_0/kernel/Initializer/truncated_normal/mean*
T0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
main_graph_0/hidden_0/kernel
VariableV2*
dtype0*
shared_name *
shape
:15*
	container */
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
#main_graph_0/hidden_0/kernel/AssignAssignmain_graph_0/hidden_0/kernel9main_graph_0/hidden_0/kernel/Initializer/truncated_normal*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
!main_graph_0/hidden_0/kernel/readIdentitymain_graph_0/hidden_0/kernel*
T0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
<main_graph_0/hidden_0/bias/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
2main_graph_0/hidden_0/bias/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
,main_graph_0/hidden_0/bias/Initializer/zerosFill<main_graph_0/hidden_0/bias/Initializer/zeros/shape_as_tensor2main_graph_0/hidden_0/bias/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
main_graph_0/hidden_0/bias
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_0/hidden_0/bias
?
!main_graph_0/hidden_0/bias/AssignAssignmain_graph_0/hidden_0/bias,main_graph_0/hidden_0/bias/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_0/bias

main_graph_0/hidden_0/bias/readIdentitymain_graph_0/hidden_0/bias*
T0*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
main_graph_0/hidden_0/MatMulMatMulnormalized_state!main_graph_0/hidden_0/kernel/read*
transpose_b( *
T0*
transpose_a( 
?
main_graph_0/hidden_0/BiasAddBiasAddmain_graph_0/hidden_0/MatMulmain_graph_0/hidden_0/bias/read*
T0*
data_formatNHWC
P
main_graph_0/hidden_0/SigmoidSigmoidmain_graph_0/hidden_0/BiasAdd*
T0
g
main_graph_0/hidden_0/MulMulmain_graph_0/hidden_0/BiasAddmain_graph_0/hidden_0/Sigmoid*
T0
?
?main_graph_0/hidden_1/kernel/Initializer/truncated_normal/shapeConst*
valueB"5   5   *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
>main_graph_0/hidden_1/kernel/Initializer/truncated_normal/meanConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
@main_graph_0/hidden_1/kernel/Initializer/truncated_normal/stddevConst*
valueB
 *?_ >*
dtype0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
Imain_graph_0/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormal?main_graph_0/hidden_1/kernel/Initializer/truncated_normal/shape*
T0*
dtype0*
seed2M*/
_class%
#!loc:@main_graph_0/hidden_1/kernel*
seed?
?
=main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mulMulImain_graph_0/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormal@main_graph_0/hidden_1/kernel/Initializer/truncated_normal/stddev*
T0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
9main_graph_0/hidden_1/kernel/Initializer/truncated_normalAdd=main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mul>main_graph_0/hidden_1/kernel/Initializer/truncated_normal/mean*
T0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
main_graph_0/hidden_1/kernel
VariableV2*
dtype0*
shared_name *
shape
:55*
	container */
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
#main_graph_0/hidden_1/kernel/AssignAssignmain_graph_0/hidden_1/kernel9main_graph_0/hidden_1/kernel/Initializer/truncated_normal*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
!main_graph_0/hidden_1/kernel/readIdentitymain_graph_0/hidden_1/kernel*
T0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
<main_graph_0/hidden_1/bias/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
2main_graph_0/hidden_1/bias/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
,main_graph_0/hidden_1/bias/Initializer/zerosFill<main_graph_0/hidden_1/bias/Initializer/zeros/shape_as_tensor2main_graph_0/hidden_1/bias/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
main_graph_0/hidden_1/bias
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_0/hidden_1/bias
?
!main_graph_0/hidden_1/bias/AssignAssignmain_graph_0/hidden_1/bias,main_graph_0/hidden_1/bias/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_1/bias

main_graph_0/hidden_1/bias/readIdentitymain_graph_0/hidden_1/bias*
T0*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
main_graph_0/hidden_1/MatMulMatMulmain_graph_0/hidden_0/Mul!main_graph_0/hidden_1/kernel/read*
transpose_b( *
T0*
transpose_a( 
?
main_graph_0/hidden_1/BiasAddBiasAddmain_graph_0/hidden_1/MatMulmain_graph_0/hidden_1/bias/read*
T0*
data_formatNHWC
P
main_graph_0/hidden_1/SigmoidSigmoidmain_graph_0/hidden_1/BiasAdd*
T0
g
main_graph_0/hidden_1/MulMulmain_graph_0/hidden_1/BiasAddmain_graph_0/hidden_1/Sigmoid*
T0
?
?main_graph_0/hidden_2/kernel/Initializer/truncated_normal/shapeConst*
valueB"5   5   *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
>main_graph_0/hidden_2/kernel/Initializer/truncated_normal/meanConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
@main_graph_0/hidden_2/kernel/Initializer/truncated_normal/stddevConst*
valueB
 *?_ >*
dtype0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
Imain_graph_0/hidden_2/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormal?main_graph_0/hidden_2/kernel/Initializer/truncated_normal/shape*
T0*
dtype0*
seed2`*/
_class%
#!loc:@main_graph_0/hidden_2/kernel*
seed?
?
=main_graph_0/hidden_2/kernel/Initializer/truncated_normal/mulMulImain_graph_0/hidden_2/kernel/Initializer/truncated_normal/TruncatedNormal@main_graph_0/hidden_2/kernel/Initializer/truncated_normal/stddev*
T0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
9main_graph_0/hidden_2/kernel/Initializer/truncated_normalAdd=main_graph_0/hidden_2/kernel/Initializer/truncated_normal/mul>main_graph_0/hidden_2/kernel/Initializer/truncated_normal/mean*
T0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
main_graph_0/hidden_2/kernel
VariableV2*
dtype0*
shared_name *
shape
:55*
	container */
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
#main_graph_0/hidden_2/kernel/AssignAssignmain_graph_0/hidden_2/kernel9main_graph_0/hidden_2/kernel/Initializer/truncated_normal*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
!main_graph_0/hidden_2/kernel/readIdentitymain_graph_0/hidden_2/kernel*
T0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
<main_graph_0/hidden_2/bias/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
2main_graph_0/hidden_2/bias/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
,main_graph_0/hidden_2/bias/Initializer/zerosFill<main_graph_0/hidden_2/bias/Initializer/zeros/shape_as_tensor2main_graph_0/hidden_2/bias/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
main_graph_0/hidden_2/bias
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_0/hidden_2/bias
?
!main_graph_0/hidden_2/bias/AssignAssignmain_graph_0/hidden_2/bias,main_graph_0/hidden_2/bias/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_2/bias

main_graph_0/hidden_2/bias/readIdentitymain_graph_0/hidden_2/bias*
T0*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
main_graph_0/hidden_2/MatMulMatMulmain_graph_0/hidden_1/Mul!main_graph_0/hidden_2/kernel/read*
transpose_b( *
T0*
transpose_a( 
?
main_graph_0/hidden_2/BiasAddBiasAddmain_graph_0/hidden_2/MatMulmain_graph_0/hidden_2/bias/read*
T0*
data_formatNHWC
P
main_graph_0/hidden_2/SigmoidSigmoidmain_graph_0/hidden_2/BiasAdd*
T0
g
main_graph_0/hidden_2/MulMulmain_graph_0/hidden_2/BiasAddmain_graph_0/hidden_2/Sigmoid*
T0
?
?main_graph_1/hidden_0/kernel/Initializer/truncated_normal/shapeConst*
valueB"1   5   *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
>main_graph_1/hidden_0/kernel/Initializer/truncated_normal/meanConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
@main_graph_1/hidden_0/kernel/Initializer/truncated_normal/stddevConst*
valueB
 *??&>*
dtype0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
Imain_graph_1/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormal?main_graph_1/hidden_0/kernel/Initializer/truncated_normal/shape*
T0*
dtype0*
seed2s*/
_class%
#!loc:@main_graph_1/hidden_0/kernel*
seed?
?
=main_graph_1/hidden_0/kernel/Initializer/truncated_normal/mulMulImain_graph_1/hidden_0/kernel/Initializer/truncated_normal/TruncatedNormal@main_graph_1/hidden_0/kernel/Initializer/truncated_normal/stddev*
T0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
9main_graph_1/hidden_0/kernel/Initializer/truncated_normalAdd=main_graph_1/hidden_0/kernel/Initializer/truncated_normal/mul>main_graph_1/hidden_0/kernel/Initializer/truncated_normal/mean*
T0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
main_graph_1/hidden_0/kernel
VariableV2*
dtype0*
shared_name *
shape
:15*
	container */
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
#main_graph_1/hidden_0/kernel/AssignAssignmain_graph_1/hidden_0/kernel9main_graph_1/hidden_0/kernel/Initializer/truncated_normal*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
!main_graph_1/hidden_0/kernel/readIdentitymain_graph_1/hidden_0/kernel*
T0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
<main_graph_1/hidden_0/bias/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
2main_graph_1/hidden_0/bias/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
,main_graph_1/hidden_0/bias/Initializer/zerosFill<main_graph_1/hidden_0/bias/Initializer/zeros/shape_as_tensor2main_graph_1/hidden_0/bias/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
main_graph_1/hidden_0/bias
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_1/hidden_0/bias
?
!main_graph_1/hidden_0/bias/AssignAssignmain_graph_1/hidden_0/bias,main_graph_1/hidden_0/bias/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_0/bias

main_graph_1/hidden_0/bias/readIdentitymain_graph_1/hidden_0/bias*
T0*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
main_graph_1/hidden_0/MatMulMatMulnormalized_state!main_graph_1/hidden_0/kernel/read*
transpose_b( *
T0*
transpose_a( 
?
main_graph_1/hidden_0/BiasAddBiasAddmain_graph_1/hidden_0/MatMulmain_graph_1/hidden_0/bias/read*
T0*
data_formatNHWC
P
main_graph_1/hidden_0/SigmoidSigmoidmain_graph_1/hidden_0/BiasAdd*
T0
g
main_graph_1/hidden_0/MulMulmain_graph_1/hidden_0/BiasAddmain_graph_1/hidden_0/Sigmoid*
T0
?
?main_graph_1/hidden_1/kernel/Initializer/truncated_normal/shapeConst*
valueB"5   5   *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
>main_graph_1/hidden_1/kernel/Initializer/truncated_normal/meanConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
@main_graph_1/hidden_1/kernel/Initializer/truncated_normal/stddevConst*
valueB
 *?_ >*
dtype0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
Imain_graph_1/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormal?main_graph_1/hidden_1/kernel/Initializer/truncated_normal/shape*
T0*
dtype0*
seed2?*/
_class%
#!loc:@main_graph_1/hidden_1/kernel*
seed?
?
=main_graph_1/hidden_1/kernel/Initializer/truncated_normal/mulMulImain_graph_1/hidden_1/kernel/Initializer/truncated_normal/TruncatedNormal@main_graph_1/hidden_1/kernel/Initializer/truncated_normal/stddev*
T0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
9main_graph_1/hidden_1/kernel/Initializer/truncated_normalAdd=main_graph_1/hidden_1/kernel/Initializer/truncated_normal/mul>main_graph_1/hidden_1/kernel/Initializer/truncated_normal/mean*
T0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
main_graph_1/hidden_1/kernel
VariableV2*
dtype0*
shared_name *
shape
:55*
	container */
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
#main_graph_1/hidden_1/kernel/AssignAssignmain_graph_1/hidden_1/kernel9main_graph_1/hidden_1/kernel/Initializer/truncated_normal*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
!main_graph_1/hidden_1/kernel/readIdentitymain_graph_1/hidden_1/kernel*
T0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
<main_graph_1/hidden_1/bias/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
2main_graph_1/hidden_1/bias/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
,main_graph_1/hidden_1/bias/Initializer/zerosFill<main_graph_1/hidden_1/bias/Initializer/zeros/shape_as_tensor2main_graph_1/hidden_1/bias/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
main_graph_1/hidden_1/bias
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_1/hidden_1/bias
?
!main_graph_1/hidden_1/bias/AssignAssignmain_graph_1/hidden_1/bias,main_graph_1/hidden_1/bias/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_1/bias

main_graph_1/hidden_1/bias/readIdentitymain_graph_1/hidden_1/bias*
T0*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
main_graph_1/hidden_1/MatMulMatMulmain_graph_1/hidden_0/Mul!main_graph_1/hidden_1/kernel/read*
transpose_b( *
T0*
transpose_a( 
?
main_graph_1/hidden_1/BiasAddBiasAddmain_graph_1/hidden_1/MatMulmain_graph_1/hidden_1/bias/read*
T0*
data_formatNHWC
P
main_graph_1/hidden_1/SigmoidSigmoidmain_graph_1/hidden_1/BiasAdd*
T0
g
main_graph_1/hidden_1/MulMulmain_graph_1/hidden_1/BiasAddmain_graph_1/hidden_1/Sigmoid*
T0
?
?main_graph_1/hidden_2/kernel/Initializer/truncated_normal/shapeConst*
valueB"5   5   *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
>main_graph_1/hidden_2/kernel/Initializer/truncated_normal/meanConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
@main_graph_1/hidden_2/kernel/Initializer/truncated_normal/stddevConst*
valueB
 *?_ >*
dtype0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
Imain_graph_1/hidden_2/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormal?main_graph_1/hidden_2/kernel/Initializer/truncated_normal/shape*
T0*
dtype0*
seed2?*/
_class%
#!loc:@main_graph_1/hidden_2/kernel*
seed?
?
=main_graph_1/hidden_2/kernel/Initializer/truncated_normal/mulMulImain_graph_1/hidden_2/kernel/Initializer/truncated_normal/TruncatedNormal@main_graph_1/hidden_2/kernel/Initializer/truncated_normal/stddev*
T0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
9main_graph_1/hidden_2/kernel/Initializer/truncated_normalAdd=main_graph_1/hidden_2/kernel/Initializer/truncated_normal/mul>main_graph_1/hidden_2/kernel/Initializer/truncated_normal/mean*
T0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
main_graph_1/hidden_2/kernel
VariableV2*
dtype0*
shared_name *
shape
:55*
	container */
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
#main_graph_1/hidden_2/kernel/AssignAssignmain_graph_1/hidden_2/kernel9main_graph_1/hidden_2/kernel/Initializer/truncated_normal*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
!main_graph_1/hidden_2/kernel/readIdentitymain_graph_1/hidden_2/kernel*
T0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
<main_graph_1/hidden_2/bias/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
2main_graph_1/hidden_2/bias/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
,main_graph_1/hidden_2/bias/Initializer/zerosFill<main_graph_1/hidden_2/bias/Initializer/zeros/shape_as_tensor2main_graph_1/hidden_2/bias/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
main_graph_1/hidden_2/bias
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_1/hidden_2/bias
?
!main_graph_1/hidden_2/bias/AssignAssignmain_graph_1/hidden_2/bias,main_graph_1/hidden_2/bias/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_2/bias

main_graph_1/hidden_2/bias/readIdentitymain_graph_1/hidden_2/bias*
T0*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
main_graph_1/hidden_2/MatMulMatMulmain_graph_1/hidden_1/Mul!main_graph_1/hidden_2/kernel/read*
transpose_b( *
T0*
transpose_a( 
?
main_graph_1/hidden_2/BiasAddBiasAddmain_graph_1/hidden_2/MatMulmain_graph_1/hidden_2/bias/read*
T0*
data_formatNHWC
P
main_graph_1/hidden_2/SigmoidSigmoidmain_graph_1/hidden_2/BiasAdd*
T0
g
main_graph_1/hidden_2/MulMulmain_graph_1/hidden_2/BiasAddmain_graph_1/hidden_2/Sigmoid*
T0
?
/dense/kernel/Initializer/truncated_normal/shapeConst*
valueB"5      *
dtype0*
_class
loc:@dense/kernel
|
.dense/kernel/Initializer/truncated_normal/meanConst*
valueB
 *    *
dtype0*
_class
loc:@dense/kernel
~
0dense/kernel/Initializer/truncated_normal/stddevConst*
valueB
 *?L?<*
dtype0*
_class
loc:@dense/kernel
?
9dense/kernel/Initializer/truncated_normal/TruncatedNormalTruncatedNormal/dense/kernel/Initializer/truncated_normal/shape*
T0*
dtype0*
seed2?*
_class
loc:@dense/kernel*
seed?
?
-dense/kernel/Initializer/truncated_normal/mulMul9dense/kernel/Initializer/truncated_normal/TruncatedNormal0dense/kernel/Initializer/truncated_normal/stddev*
T0*
_class
loc:@dense/kernel
?
)dense/kernel/Initializer/truncated_normalAdd-dense/kernel/Initializer/truncated_normal/mul.dense/kernel/Initializer/truncated_normal/mean*
T0*
_class
loc:@dense/kernel
?
dense/kernel
VariableV2*
dtype0*
shared_name *
shape
:5*
	container *
_class
loc:@dense/kernel
?
dense/kernel/AssignAssigndense/kernel)dense/kernel/Initializer/truncated_normal*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/kernel
U
dense/kernel/readIdentitydense/kernel*
T0*
_class
loc:@dense/kernel
y
,dense/bias/Initializer/zeros/shape_as_tensorConst*
valueB:*
dtype0*
_class
loc:@dense/bias
n
"dense/bias/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*
_class
loc:@dense/bias
?
dense/bias/Initializer/zerosFill,dense/bias/Initializer/zeros/shape_as_tensor"dense/bias/Initializer/zeros/Const*
T0*

index_type0*
_class
loc:@dense/bias
y

dense/bias
VariableV2*
dtype0*
shared_name *
shape:*
	container *
_class
loc:@dense/bias
?
dense/bias/AssignAssign
dense/biasdense/bias/Initializer/zeros*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/bias
O
dense/bias/readIdentity
dense/bias*
T0*
_class
loc:@dense/bias
s
dense/MatMulMatMulmain_graph_0/hidden_2/Muldense/kernel/read*
transpose_b( *
T0*
transpose_a( 
W
dense/BiasAddBiasAdddense/MatMuldense/bias/read*
T0*
data_formatNHWC
?
3log_sigma_squared/Initializer/zeros/shape_as_tensorConst*
valueB:*
dtype0*$
_class
loc:@log_sigma_squared
|
)log_sigma_squared/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*$
_class
loc:@log_sigma_squared
?
#log_sigma_squared/Initializer/zerosFill3log_sigma_squared/Initializer/zeros/shape_as_tensor)log_sigma_squared/Initializer/zeros/Const*
T0*

index_type0*$
_class
loc:@log_sigma_squared
?
log_sigma_squared
VariableV2*
dtype0*
shared_name *
shape:*
	container *$
_class
loc:@log_sigma_squared
?
log_sigma_squared/AssignAssignlog_sigma_squared#log_sigma_squared/Initializer/zeros*
T0*
use_locking(*
validate_shape(*$
_class
loc:@log_sigma_squared
d
log_sigma_squared/readIdentitylog_sigma_squared*
T0*$
_class
loc:@log_sigma_squared
+
ExpExplog_sigma_squared/read*
T0
6
ShapeShapedense/BiasAdd*
T0*
out_type0
?
random_normal/meanConst*
valueB
 *    *
dtype0
A
random_normal/stddevConst*
valueB
 *  ??*
dtype0
r
"random_normal/RandomStandardNormalRandomStandardNormalShape*
T0*
dtype0*
seed2?*
seed?
[
random_normal/mulMul"random_normal/RandomStandardNormalrandom_normal/stddev*
T0
D
random_normalAddrandom_normal/mulrandom_normal/mean*
T0

Sqrt_1SqrtExp*
T0
,
mul_1MulSqrt_1random_normal*
T0
+
add_3Adddense/BiasAddmul_1*
T0
D
clip_by_value/Minimum/yConst*
valueB
 *  @@*
dtype0
I
clip_by_value/MinimumMinimumadd_3clip_by_value/Minimum/y*
T0
<
clip_by_value/yConst*
valueB
 *  @?*
dtype0
I
clip_by_valueMaximumclip_by_value/Minimumclip_by_value/y*
T0
8
truediv_3/yConst*
valueB
 *  @@*
dtype0
9
	truediv_3RealDivclip_by_valuetruediv_3/y*
T0
&
actionIdentity	truediv_3*
T0
0
StopGradientStopGradient	truediv_3*
T0
.
StopGradient_1StopGradientadd_3*
T0
4
sub_4SubStopGradient_1dense/BiasAdd*
T0
 
SquareSquaresub_4*
T0
4
mul_2/xConst*
valueB
 *   ?*
dtype0
&
mul_2Mulmul_2/xSquare*
T0
)
	truediv_4RealDivmul_2Exp*
T0
2
Log/xConst*
valueB
 *??@*
dtype0

LogLogLog/x*
T0
4
mul_3/xConst*
valueB
 *   ?*
dtype0
#
mul_3Mulmul_3/xLog*
T0
'
sub_5Sub	truediv_4mul_3*
T0
4
mul_4/xConst*
valueB
 *   ?*
dtype0
6
mul_4Mulmul_4/xlog_sigma_squared/read*
T0
#
sub_6Subsub_5mul_4*
T0
(
action_probsIdentitysub_6*
T0
4
Log_1/xConst*
valueB
 *???A*
dtype0

Log_1LogLog_1/x*
T0
4
add_4AddLog_1log_sigma_squared/read*
T0
3
ConstConst*
valueB: *
dtype0
B
Mean_1Meanadd_4Const*
	keep_dims( *
T0*

Tidx0
4
mul_5/xConst*
valueB
 *   ?*
dtype0
&
mul_5Mulmul_5/xMean_1*
T0
?
/dense_1/kernel/Initializer/random_uniform/shapeConst*
valueB"5      *
dtype0*!
_class
loc:@dense_1/kernel
}
-dense_1/kernel/Initializer/random_uniform/minConst*
valueB
 *????*
dtype0*!
_class
loc:@dense_1/kernel
}
-dense_1/kernel/Initializer/random_uniform/maxConst*
valueB
 *???>*
dtype0*!
_class
loc:@dense_1/kernel
?
7dense_1/kernel/Initializer/random_uniform/RandomUniformRandomUniform/dense_1/kernel/Initializer/random_uniform/shape*
T0*
dtype0*
seed2?*!
_class
loc:@dense_1/kernel*
seed?
?
-dense_1/kernel/Initializer/random_uniform/subSub-dense_1/kernel/Initializer/random_uniform/max-dense_1/kernel/Initializer/random_uniform/min*
T0*!
_class
loc:@dense_1/kernel
?
-dense_1/kernel/Initializer/random_uniform/mulMul7dense_1/kernel/Initializer/random_uniform/RandomUniform-dense_1/kernel/Initializer/random_uniform/sub*
T0*!
_class
loc:@dense_1/kernel
?
)dense_1/kernel/Initializer/random_uniformAdd-dense_1/kernel/Initializer/random_uniform/mul-dense_1/kernel/Initializer/random_uniform/min*
T0*!
_class
loc:@dense_1/kernel
?
dense_1/kernel
VariableV2*
dtype0*
shared_name *
shape
:5*
	container *!
_class
loc:@dense_1/kernel
?
dense_1/kernel/AssignAssigndense_1/kernel)dense_1/kernel/Initializer/random_uniform*
T0*
use_locking(*
validate_shape(*!
_class
loc:@dense_1/kernel
[
dense_1/kernel/readIdentitydense_1/kernel*
T0*!
_class
loc:@dense_1/kernel
}
.dense_1/bias/Initializer/zeros/shape_as_tensorConst*
valueB:*
dtype0*
_class
loc:@dense_1/bias
r
$dense_1/bias/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*
_class
loc:@dense_1/bias
?
dense_1/bias/Initializer/zerosFill.dense_1/bias/Initializer/zeros/shape_as_tensor$dense_1/bias/Initializer/zeros/Const*
T0*

index_type0*
_class
loc:@dense_1/bias
}
dense_1/bias
VariableV2*
dtype0*
shared_name *
shape:*
	container *
_class
loc:@dense_1/bias
?
dense_1/bias/AssignAssigndense_1/biasdense_1/bias/Initializer/zeros*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense_1/bias
U
dense_1/bias/readIdentitydense_1/bias*
T0*
_class
loc:@dense_1/bias
w
dense_1/MatMulMatMulmain_graph_1/hidden_2/Muldense_1/kernel/read*
transpose_b( *
T0*
transpose_a( 
]
dense_1/BiasAddBiasAdddense_1/MatMuldense_1/bias/read*
T0*
data_formatNHWC
4
value_estimateIdentitydense_1/BiasAdd*
T0
K
old_probabilitiesPlaceholder*
dtype0*
shape:?????????
+
IdentityIdentityaction_probs*
T0
?
Sum/reduction_indicesConst*
value	B :*
dtype0
Q
SumSumIdentitySum/reduction_indices*
	keep_dims(*
T0*

Tidx0
2

Identity_1Identityold_probabilities*
T0
A
Sum_1/reduction_indicesConst*
value	B :*
dtype0
W
Sum_1Sum
Identity_1Sum_1/reduction_indices*
	keep_dims(*
T0*

Tidx0
D
Reshape/shapeConst*
valueB:
?????????*
dtype0
H
ReshapeReshapevalue_estimateReshape/shape*
T0*
Tshape0
:
ones_like/ShapeShapeReshape*
T0*
out_type0
<
ones_like/ConstConst*
valueB
 *  ??*
dtype0
N
	ones_likeFillones_like/Shapeones_like/Const*
T0*

index_type0
'
mul_6Mul	ones_likemul_5*
T0
H
discounted_rewardsPlaceholder*
dtype0*
shape:?????????
D

advantagesPlaceholder*
dtype0*
shape:?????????
J
PolynomialDecay/learning_rateConst*
valueB
 *o?:*
dtype0
F
PolynomialDecay/CastCastglobal_step/read*

DstT0*

SrcT0
E
PolynomialDecay/Cast_1/xConst*
valueB
 * |?H*
dtype0
E
PolynomialDecay/Cast_2/xConst*
valueB
 *???.*
dtype0
E
PolynomialDecay/Cast_3/xConst*
valueB
 *  ??*
dtype0
[
PolynomialDecay/MinimumMinimumPolynomialDecay/CastPolynomialDecay/Cast_1/x*
T0
Z
PolynomialDecay/divRealDivPolynomialDecay/MinimumPolynomialDecay/Cast_1/x*
T0
\
PolynomialDecay/subSubPolynomialDecay/learning_ratePolynomialDecay/Cast_2/x*
T0
D
PolynomialDecay/sub_1/xConst*
valueB
 *  ??*
dtype0
S
PolynomialDecay/sub_1SubPolynomialDecay/sub_1/xPolynomialDecay/div*
T0
T
PolynomialDecay/PowPowPolynomialDecay/sub_1PolynomialDecay/Cast_3/x*
T0
M
PolynomialDecay/MulMulPolynomialDecay/subPolynomialDecay/Pow*
T0
N
PolynomialDecayAddPolynomialDecay/MulPolynomialDecay/Cast_2/x*
T0
I
old_value_estimatesPlaceholder*
dtype0*
shape:?????????
L
PolynomialDecay_1/learning_rateConst*
valueB
 *??L>*
dtype0
H
PolynomialDecay_1/CastCastglobal_step/read*

DstT0*

SrcT0
G
PolynomialDecay_1/Cast_1/xConst*
valueB
 * |?H*
dtype0
G
PolynomialDecay_1/Cast_2/xConst*
valueB
 *???=*
dtype0
G
PolynomialDecay_1/Cast_3/xConst*
valueB
 *  ??*
dtype0
a
PolynomialDecay_1/MinimumMinimumPolynomialDecay_1/CastPolynomialDecay_1/Cast_1/x*
T0
`
PolynomialDecay_1/divRealDivPolynomialDecay_1/MinimumPolynomialDecay_1/Cast_1/x*
T0
b
PolynomialDecay_1/subSubPolynomialDecay_1/learning_ratePolynomialDecay_1/Cast_2/x*
T0
F
PolynomialDecay_1/sub_1/xConst*
valueB
 *  ??*
dtype0
Y
PolynomialDecay_1/sub_1SubPolynomialDecay_1/sub_1/xPolynomialDecay_1/div*
T0
Z
PolynomialDecay_1/PowPowPolynomialDecay_1/sub_1PolynomialDecay_1/Cast_3/x*
T0
S
PolynomialDecay_1/MulMulPolynomialDecay_1/subPolynomialDecay_1/Pow*
T0
T
PolynomialDecay_1AddPolynomialDecay_1/MulPolynomialDecay_1/Cast_2/x*
T0
L
PolynomialDecay_2/learning_rateConst*
valueB
 *
ף;*
dtype0
H
PolynomialDecay_2/CastCastglobal_step/read*

DstT0*

SrcT0
G
PolynomialDecay_2/Cast_1/xConst*
valueB
 * |?H*
dtype0
G
PolynomialDecay_2/Cast_2/xConst*
valueB
 *??'7*
dtype0
G
PolynomialDecay_2/Cast_3/xConst*
valueB
 *  ??*
dtype0
a
PolynomialDecay_2/MinimumMinimumPolynomialDecay_2/CastPolynomialDecay_2/Cast_1/x*
T0
`
PolynomialDecay_2/divRealDivPolynomialDecay_2/MinimumPolynomialDecay_2/Cast_1/x*
T0
b
PolynomialDecay_2/subSubPolynomialDecay_2/learning_ratePolynomialDecay_2/Cast_2/x*
T0
F
PolynomialDecay_2/sub_1/xConst*
valueB
 *  ??*
dtype0
Y
PolynomialDecay_2/sub_1SubPolynomialDecay_2/sub_1/xPolynomialDecay_2/div*
T0
Z
PolynomialDecay_2/PowPowPolynomialDecay_2/sub_1PolynomialDecay_2/Cast_3/x*
T0
S
PolynomialDecay_2/MulMulPolynomialDecay_2/subPolynomialDecay_2/Pow*
T0
T
PolynomialDecay_2AddPolynomialDecay_2/MulPolynomialDecay_2/Cast_2/x*
T0
A
Sum_2/reduction_indicesConst*
value	B :*
dtype0
[
Sum_2Sumvalue_estimateSum_2/reduction_indices*
	keep_dims( *
T0*

Tidx0
1
sub_7SubSum_2old_value_estimates*
T0
&
NegNegPolynomialDecay_1*
T0
E
clip_by_value_1/MinimumMinimumsub_7PolynomialDecay_1*
T0
A
clip_by_value_1Maximumclip_by_value_1/MinimumNeg*
T0
;
add_5Addold_value_estimatesclip_by_value_1*
T0
A
Sum_3/reduction_indicesConst*
value	B :*
dtype0
[
Sum_3Sumvalue_estimateSum_3/reduction_indices*
	keep_dims( *
T0*

Tidx0
J
SquaredDifferenceSquaredDifferencediscounted_rewardsSum_3*
T0
L
SquaredDifference_1SquaredDifferencediscounted_rewardsadd_5*
T0
C
MaximumMaximumSquaredDifferenceSquaredDifference_1*
T0
R
DynamicPartitionDynamicPartitionMaximumCast*
T0*
num_partitions
5
Const_1Const*
valueB: *
dtype0
Q
Mean_2MeanDynamicPartition:1Const_1*
	keep_dims( *
T0*

Tidx0
!
sub_8SubSumSum_1*
T0

Exp_1Expsub_8*
T0
(
mul_7MulExp_1
advantages*
T0
4
sub_9/xConst*
valueB
 *  ??*
dtype0
1
sub_9Subsub_9/xPolynomialDecay_1*
T0
4
add_6/xConst*
valueB
 *  ??*
dtype0
1
add_6Addadd_6/xPolynomialDecay_1*
T0
9
clip_by_value_2/MinimumMinimumExp_1add_6*
T0
C
clip_by_value_2Maximumclip_by_value_2/Minimumsub_9*
T0
2
mul_8Mulclip_by_value_2
advantages*
T0
)
MinimumMinimummul_7mul_8*
T0
T
DynamicPartition_1DynamicPartitionMinimumCast*
T0*
num_partitions
<
Const_2Const*
valueB"       *
dtype0
S
Mean_3MeanDynamicPartition_1:1Const_2*
	keep_dims( *
T0*

Tidx0

Neg_1NegMean_3*
T0
4
mul_9/xConst*
valueB
 *   ?*
dtype0
&
mul_9Mulmul_9/xMean_2*
T0
#
add_7AddNeg_1mul_9*
T0
R
DynamicPartition_2DynamicPartitionmul_6Cast*
T0*
num_partitions
5
Const_3Const*
valueB: *
dtype0
S
Mean_4MeanDynamicPartition_2:1Const_3*
	keep_dims( *
T0*

Tidx0
1
mul_10MulPolynomialDecay_2Mean_4*
T0
%
sub_10Subadd_7mul_10*
T0
8
gradients/ShapeConst*
valueB *
dtype0
@
gradients/grad_ys_0Const*
valueB
 *  ??*
dtype0
W
gradients/FillFillgradients/Shapegradients/grad_ys_0*
T0*

index_type0
9
gradients/sub_10_grad/NegNeggradients/Fill*
T0
[
&gradients/sub_10_grad/tuple/group_depsNoOp^gradients/Fill^gradients/sub_10_grad/Neg
?
.gradients/sub_10_grad/tuple/control_dependencyIdentitygradients/Fill'^gradients/sub_10_grad/tuple/group_deps*
T0*!
_class
loc:@gradients/Fill
?
0gradients/sub_10_grad/tuple/control_dependency_1Identitygradients/sub_10_grad/Neg'^gradients/sub_10_grad/tuple/group_deps*
T0*,
_class"
 loc:@gradients/sub_10_grad/Neg
^
%gradients/add_7_grad/tuple/group_depsNoOp/^gradients/sub_10_grad/tuple/control_dependency
?
-gradients/add_7_grad/tuple/control_dependencyIdentity.gradients/sub_10_grad/tuple/control_dependency&^gradients/add_7_grad/tuple/group_deps*
T0*!
_class
loc:@gradients/Fill
?
/gradients/add_7_grad/tuple/control_dependency_1Identity.gradients/sub_10_grad/tuple/control_dependency&^gradients/add_7_grad/tuple/group_deps*
T0*!
_class
loc:@gradients/Fill
c
gradients/mul_10_grad/MulMul0gradients/sub_10_grad/tuple/control_dependency_1Mean_4*
T0
p
gradients/mul_10_grad/Mul_1Mul0gradients/sub_10_grad/tuple/control_dependency_1PolynomialDecay_2*
T0
h
&gradients/mul_10_grad/tuple/group_depsNoOp^gradients/mul_10_grad/Mul^gradients/mul_10_grad/Mul_1
?
.gradients/mul_10_grad/tuple/control_dependencyIdentitygradients/mul_10_grad/Mul'^gradients/mul_10_grad/tuple/group_deps*
T0*,
_class"
 loc:@gradients/mul_10_grad/Mul
?
0gradients/mul_10_grad/tuple/control_dependency_1Identitygradients/mul_10_grad/Mul_1'^gradients/mul_10_grad/tuple/group_deps*
T0*.
_class$
" loc:@gradients/mul_10_grad/Mul_1
W
gradients/Neg_1_grad/NegNeg-gradients/add_7_grad/tuple/control_dependency*
T0
a
gradients/mul_9_grad/MulMul/gradients/add_7_grad/tuple/control_dependency_1Mean_2*
T0
d
gradients/mul_9_grad/Mul_1Mul/gradients/add_7_grad/tuple/control_dependency_1mul_9/x*
T0
e
%gradients/mul_9_grad/tuple/group_depsNoOp^gradients/mul_9_grad/Mul^gradients/mul_9_grad/Mul_1
?
-gradients/mul_9_grad/tuple/control_dependencyIdentitygradients/mul_9_grad/Mul&^gradients/mul_9_grad/tuple/group_deps*
T0*+
_class!
loc:@gradients/mul_9_grad/Mul
?
/gradients/mul_9_grad/tuple/control_dependency_1Identitygradients/mul_9_grad/Mul_1&^gradients/mul_9_grad/tuple/group_deps*
T0*-
_class#
!loc:@gradients/mul_9_grad/Mul_1
Q
#gradients/Mean_4_grad/Reshape/shapeConst*
valueB:*
dtype0
?
gradients/Mean_4_grad/ReshapeReshape0gradients/mul_10_grad/tuple/control_dependency_1#gradients/Mean_4_grad/Reshape/shape*
T0*
Tshape0
S
gradients/Mean_4_grad/ShapeShapeDynamicPartition_2:1*
T0*
out_type0
y
gradients/Mean_4_grad/TileTilegradients/Mean_4_grad/Reshapegradients/Mean_4_grad/Shape*
T0*

Tmultiples0
U
gradients/Mean_4_grad/Shape_1ShapeDynamicPartition_2:1*
T0*
out_type0
F
gradients/Mean_4_grad/Shape_2Const*
valueB *
dtype0
I
gradients/Mean_4_grad/ConstConst*
valueB: *
dtype0
?
gradients/Mean_4_grad/ProdProdgradients/Mean_4_grad/Shape_1gradients/Mean_4_grad/Const*
	keep_dims( *
T0*

Tidx0
K
gradients/Mean_4_grad/Const_1Const*
valueB: *
dtype0
?
gradients/Mean_4_grad/Prod_1Prodgradients/Mean_4_grad/Shape_2gradients/Mean_4_grad/Const_1*
	keep_dims( *
T0*

Tidx0
I
gradients/Mean_4_grad/Maximum/yConst*
value	B :*
dtype0
p
gradients/Mean_4_grad/MaximumMaximumgradients/Mean_4_grad/Prod_1gradients/Mean_4_grad/Maximum/y*
T0
n
gradients/Mean_4_grad/floordivFloorDivgradients/Mean_4_grad/Prodgradients/Mean_4_grad/Maximum*
T0
Z
gradients/Mean_4_grad/CastCastgradients/Mean_4_grad/floordiv*

DstT0*

SrcT0
i
gradients/Mean_4_grad/truedivRealDivgradients/Mean_4_grad/Tilegradients/Mean_4_grad/Cast*
T0
X
#gradients/Mean_3_grad/Reshape/shapeConst*
valueB"      *
dtype0
~
gradients/Mean_3_grad/ReshapeReshapegradients/Neg_1_grad/Neg#gradients/Mean_3_grad/Reshape/shape*
T0*
Tshape0
S
gradients/Mean_3_grad/ShapeShapeDynamicPartition_1:1*
T0*
out_type0
y
gradients/Mean_3_grad/TileTilegradients/Mean_3_grad/Reshapegradients/Mean_3_grad/Shape*
T0*

Tmultiples0
U
gradients/Mean_3_grad/Shape_1ShapeDynamicPartition_1:1*
T0*
out_type0
F
gradients/Mean_3_grad/Shape_2Const*
valueB *
dtype0
I
gradients/Mean_3_grad/ConstConst*
valueB: *
dtype0
?
gradients/Mean_3_grad/ProdProdgradients/Mean_3_grad/Shape_1gradients/Mean_3_grad/Const*
	keep_dims( *
T0*

Tidx0
K
gradients/Mean_3_grad/Const_1Const*
valueB: *
dtype0
?
gradients/Mean_3_grad/Prod_1Prodgradients/Mean_3_grad/Shape_2gradients/Mean_3_grad/Const_1*
	keep_dims( *
T0*

Tidx0
I
gradients/Mean_3_grad/Maximum/yConst*
value	B :*
dtype0
p
gradients/Mean_3_grad/MaximumMaximumgradients/Mean_3_grad/Prod_1gradients/Mean_3_grad/Maximum/y*
T0
n
gradients/Mean_3_grad/floordivFloorDivgradients/Mean_3_grad/Prodgradients/Mean_3_grad/Maximum*
T0
Z
gradients/Mean_3_grad/CastCastgradients/Mean_3_grad/floordiv*

DstT0*

SrcT0
i
gradients/Mean_3_grad/truedivRealDivgradients/Mean_3_grad/Tilegradients/Mean_3_grad/Cast*
T0
Q
#gradients/Mean_2_grad/Reshape/shapeConst*
valueB:*
dtype0
?
gradients/Mean_2_grad/ReshapeReshape/gradients/mul_9_grad/tuple/control_dependency_1#gradients/Mean_2_grad/Reshape/shape*
T0*
Tshape0
Q
gradients/Mean_2_grad/ShapeShapeDynamicPartition:1*
T0*
out_type0
y
gradients/Mean_2_grad/TileTilegradients/Mean_2_grad/Reshapegradients/Mean_2_grad/Shape*
T0*

Tmultiples0
S
gradients/Mean_2_grad/Shape_1ShapeDynamicPartition:1*
T0*
out_type0
F
gradients/Mean_2_grad/Shape_2Const*
valueB *
dtype0
I
gradients/Mean_2_grad/ConstConst*
valueB: *
dtype0
?
gradients/Mean_2_grad/ProdProdgradients/Mean_2_grad/Shape_1gradients/Mean_2_grad/Const*
	keep_dims( *
T0*

Tidx0
K
gradients/Mean_2_grad/Const_1Const*
valueB: *
dtype0
?
gradients/Mean_2_grad/Prod_1Prodgradients/Mean_2_grad/Shape_2gradients/Mean_2_grad/Const_1*
	keep_dims( *
T0*

Tidx0
I
gradients/Mean_2_grad/Maximum/yConst*
value	B :*
dtype0
p
gradients/Mean_2_grad/MaximumMaximumgradients/Mean_2_grad/Prod_1gradients/Mean_2_grad/Maximum/y*
T0
n
gradients/Mean_2_grad/floordivFloorDivgradients/Mean_2_grad/Prodgradients/Mean_2_grad/Maximum*
T0
Z
gradients/Mean_2_grad/CastCastgradients/Mean_2_grad/floordiv*

DstT0*

SrcT0
i
gradients/Mean_2_grad/truedivRealDivgradients/Mean_2_grad/Tilegradients/Mean_2_grad/Cast*
T0
>
gradients/zeros_like	ZerosLikeDynamicPartition_2*
T0
O
'gradients/DynamicPartition_2_grad/ShapeShapeCast*
T0*
out_type0
U
'gradients/DynamicPartition_2_grad/ConstConst*
valueB: *
dtype0
?
&gradients/DynamicPartition_2_grad/ProdProd'gradients/DynamicPartition_2_grad/Shape'gradients/DynamicPartition_2_grad/Const*
	keep_dims( *
T0*

Tidx0
W
-gradients/DynamicPartition_2_grad/range/startConst*
value	B : *
dtype0
W
-gradients/DynamicPartition_2_grad/range/deltaConst*
value	B :*
dtype0
?
'gradients/DynamicPartition_2_grad/rangeRange-gradients/DynamicPartition_2_grad/range/start&gradients/DynamicPartition_2_grad/Prod-gradients/DynamicPartition_2_grad/range/delta*

Tidx0
?
)gradients/DynamicPartition_2_grad/ReshapeReshape'gradients/DynamicPartition_2_grad/range'gradients/DynamicPartition_2_grad/Shape*
T0*
Tshape0
?
2gradients/DynamicPartition_2_grad/DynamicPartitionDynamicPartition)gradients/DynamicPartition_2_grad/ReshapeCast*
T0*
num_partitions
?
/gradients/DynamicPartition_2_grad/DynamicStitchDynamicStitch2gradients/DynamicPartition_2_grad/DynamicPartition4gradients/DynamicPartition_2_grad/DynamicPartition:1gradients/zeros_likegradients/Mean_4_grad/truediv*
T0*
N
R
)gradients/DynamicPartition_2_grad/Shape_1Shapemul_6*
T0*
out_type0
?
+gradients/DynamicPartition_2_grad/Reshape_1Reshape/gradients/DynamicPartition_2_grad/DynamicStitch)gradients/DynamicPartition_2_grad/Shape_1*
T0*
Tshape0
@
gradients/zeros_like_1	ZerosLikeDynamicPartition_1*
T0
O
'gradients/DynamicPartition_1_grad/ShapeShapeCast*
T0*
out_type0
U
'gradients/DynamicPartition_1_grad/ConstConst*
valueB: *
dtype0
?
&gradients/DynamicPartition_1_grad/ProdProd'gradients/DynamicPartition_1_grad/Shape'gradients/DynamicPartition_1_grad/Const*
	keep_dims( *
T0*

Tidx0
W
-gradients/DynamicPartition_1_grad/range/startConst*
value	B : *
dtype0
W
-gradients/DynamicPartition_1_grad/range/deltaConst*
value	B :*
dtype0
?
'gradients/DynamicPartition_1_grad/rangeRange-gradients/DynamicPartition_1_grad/range/start&gradients/DynamicPartition_1_grad/Prod-gradients/DynamicPartition_1_grad/range/delta*

Tidx0
?
)gradients/DynamicPartition_1_grad/ReshapeReshape'gradients/DynamicPartition_1_grad/range'gradients/DynamicPartition_1_grad/Shape*
T0*
Tshape0
?
2gradients/DynamicPartition_1_grad/DynamicPartitionDynamicPartition)gradients/DynamicPartition_1_grad/ReshapeCast*
T0*
num_partitions
?
/gradients/DynamicPartition_1_grad/DynamicStitchDynamicStitch2gradients/DynamicPartition_1_grad/DynamicPartition4gradients/DynamicPartition_1_grad/DynamicPartition:1gradients/zeros_like_1gradients/Mean_3_grad/truediv*
T0*
N
T
)gradients/DynamicPartition_1_grad/Shape_1ShapeMinimum*
T0*
out_type0
?
+gradients/DynamicPartition_1_grad/Reshape_1Reshape/gradients/DynamicPartition_1_grad/DynamicStitch)gradients/DynamicPartition_1_grad/Shape_1*
T0*
Tshape0
>
gradients/zeros_like_2	ZerosLikeDynamicPartition*
T0
M
%gradients/DynamicPartition_grad/ShapeShapeCast*
T0*
out_type0
S
%gradients/DynamicPartition_grad/ConstConst*
valueB: *
dtype0
?
$gradients/DynamicPartition_grad/ProdProd%gradients/DynamicPartition_grad/Shape%gradients/DynamicPartition_grad/Const*
	keep_dims( *
T0*

Tidx0
U
+gradients/DynamicPartition_grad/range/startConst*
value	B : *
dtype0
U
+gradients/DynamicPartition_grad/range/deltaConst*
value	B :*
dtype0
?
%gradients/DynamicPartition_grad/rangeRange+gradients/DynamicPartition_grad/range/start$gradients/DynamicPartition_grad/Prod+gradients/DynamicPartition_grad/range/delta*

Tidx0
?
'gradients/DynamicPartition_grad/ReshapeReshape%gradients/DynamicPartition_grad/range%gradients/DynamicPartition_grad/Shape*
T0*
Tshape0
?
0gradients/DynamicPartition_grad/DynamicPartitionDynamicPartition'gradients/DynamicPartition_grad/ReshapeCast*
T0*
num_partitions
?
-gradients/DynamicPartition_grad/DynamicStitchDynamicStitch0gradients/DynamicPartition_grad/DynamicPartition2gradients/DynamicPartition_grad/DynamicPartition:1gradients/zeros_like_2gradients/Mean_2_grad/truediv*
T0*
N
R
'gradients/DynamicPartition_grad/Shape_1ShapeMaximum*
T0*
out_type0
?
)gradients/DynamicPartition_grad/Reshape_1Reshape-gradients/DynamicPartition_grad/DynamicStitch'gradients/DynamicPartition_grad/Shape_1*
T0*
Tshape0
G
gradients/mul_6_grad/ShapeShape	ones_like*
T0*
out_type0
E
gradients/mul_6_grad/Shape_1Const*
valueB *
dtype0
?
*gradients/mul_6_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/mul_6_grad/Shapegradients/mul_6_grad/Shape_1*
T0
\
gradients/mul_6_grad/MulMul+gradients/DynamicPartition_2_grad/Reshape_1mul_5*
T0
?
gradients/mul_6_grad/SumSumgradients/mul_6_grad/Mul*gradients/mul_6_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
t
gradients/mul_6_grad/ReshapeReshapegradients/mul_6_grad/Sumgradients/mul_6_grad/Shape*
T0*
Tshape0
b
gradients/mul_6_grad/Mul_1Mul	ones_like+gradients/DynamicPartition_2_grad/Reshape_1*
T0
?
gradients/mul_6_grad/Sum_1Sumgradients/mul_6_grad/Mul_1,gradients/mul_6_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
z
gradients/mul_6_grad/Reshape_1Reshapegradients/mul_6_grad/Sum_1gradients/mul_6_grad/Shape_1*
T0*
Tshape0
m
%gradients/mul_6_grad/tuple/group_depsNoOp^gradients/mul_6_grad/Reshape^gradients/mul_6_grad/Reshape_1
?
-gradients/mul_6_grad/tuple/control_dependencyIdentitygradients/mul_6_grad/Reshape&^gradients/mul_6_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/mul_6_grad/Reshape
?
/gradients/mul_6_grad/tuple/control_dependency_1Identitygradients/mul_6_grad/Reshape_1&^gradients/mul_6_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/mul_6_grad/Reshape_1
E
gradients/Minimum_grad/ShapeShapemul_7*
T0*
out_type0
G
gradients/Minimum_grad/Shape_1Shapemul_8*
T0*
out_type0
m
gradients/Minimum_grad/Shape_2Shape+gradients/DynamicPartition_1_grad/Reshape_1*
T0*
out_type0
O
"gradients/Minimum_grad/zeros/ConstConst*
valueB
 *    *
dtype0
?
gradients/Minimum_grad/zerosFillgradients/Minimum_grad/Shape_2"gradients/Minimum_grad/zeros/Const*
T0*

index_type0
D
 gradients/Minimum_grad/LessEqual	LessEqualmul_7mul_8*
T0
?
,gradients/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/Minimum_grad/Shapegradients/Minimum_grad/Shape_1*
T0
?
gradients/Minimum_grad/SelectSelect gradients/Minimum_grad/LessEqual+gradients/DynamicPartition_1_grad/Reshape_1gradients/Minimum_grad/zeros*
T0
?
gradients/Minimum_grad/Select_1Select gradients/Minimum_grad/LessEqualgradients/Minimum_grad/zeros+gradients/DynamicPartition_1_grad/Reshape_1*
T0
?
gradients/Minimum_grad/SumSumgradients/Minimum_grad/Select,gradients/Minimum_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
z
gradients/Minimum_grad/ReshapeReshapegradients/Minimum_grad/Sumgradients/Minimum_grad/Shape*
T0*
Tshape0
?
gradients/Minimum_grad/Sum_1Sumgradients/Minimum_grad/Select_1.gradients/Minimum_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
 gradients/Minimum_grad/Reshape_1Reshapegradients/Minimum_grad/Sum_1gradients/Minimum_grad/Shape_1*
T0*
Tshape0
s
'gradients/Minimum_grad/tuple/group_depsNoOp^gradients/Minimum_grad/Reshape!^gradients/Minimum_grad/Reshape_1
?
/gradients/Minimum_grad/tuple/control_dependencyIdentitygradients/Minimum_grad/Reshape(^gradients/Minimum_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/Minimum_grad/Reshape
?
1gradients/Minimum_grad/tuple/control_dependency_1Identity gradients/Minimum_grad/Reshape_1(^gradients/Minimum_grad/tuple/group_deps*
T0*3
_class)
'%loc:@gradients/Minimum_grad/Reshape_1
Q
gradients/Maximum_grad/ShapeShapeSquaredDifference*
T0*
out_type0
U
gradients/Maximum_grad/Shape_1ShapeSquaredDifference_1*
T0*
out_type0
k
gradients/Maximum_grad/Shape_2Shape)gradients/DynamicPartition_grad/Reshape_1*
T0*
out_type0
O
"gradients/Maximum_grad/zeros/ConstConst*
valueB
 *    *
dtype0
?
gradients/Maximum_grad/zerosFillgradients/Maximum_grad/Shape_2"gradients/Maximum_grad/zeros/Const*
T0*

index_type0
d
#gradients/Maximum_grad/GreaterEqualGreaterEqualSquaredDifferenceSquaredDifference_1*
T0
?
,gradients/Maximum_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/Maximum_grad/Shapegradients/Maximum_grad/Shape_1*
T0
?
gradients/Maximum_grad/SelectSelect#gradients/Maximum_grad/GreaterEqual)gradients/DynamicPartition_grad/Reshape_1gradients/Maximum_grad/zeros*
T0
?
gradients/Maximum_grad/Select_1Select#gradients/Maximum_grad/GreaterEqualgradients/Maximum_grad/zeros)gradients/DynamicPartition_grad/Reshape_1*
T0
?
gradients/Maximum_grad/SumSumgradients/Maximum_grad/Select,gradients/Maximum_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
z
gradients/Maximum_grad/ReshapeReshapegradients/Maximum_grad/Sumgradients/Maximum_grad/Shape*
T0*
Tshape0
?
gradients/Maximum_grad/Sum_1Sumgradients/Maximum_grad/Select_1.gradients/Maximum_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
 gradients/Maximum_grad/Reshape_1Reshapegradients/Maximum_grad/Sum_1gradients/Maximum_grad/Shape_1*
T0*
Tshape0
s
'gradients/Maximum_grad/tuple/group_depsNoOp^gradients/Maximum_grad/Reshape!^gradients/Maximum_grad/Reshape_1
?
/gradients/Maximum_grad/tuple/control_dependencyIdentitygradients/Maximum_grad/Reshape(^gradients/Maximum_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/Maximum_grad/Reshape
?
1gradients/Maximum_grad/tuple/control_dependency_1Identity gradients/Maximum_grad/Reshape_1(^gradients/Maximum_grad/tuple/group_deps*
T0*3
_class)
'%loc:@gradients/Maximum_grad/Reshape_1
L
gradients/ones_like_grad/ConstConst*
valueB: *
dtype0
?
gradients/ones_like_grad/SumSum-gradients/mul_6_grad/tuple/control_dependencygradients/ones_like_grad/Const*
	keep_dims( *
T0*

Tidx0
a
gradients/mul_5_grad/MulMul/gradients/mul_6_grad/tuple/control_dependency_1Mean_1*
T0
d
gradients/mul_5_grad/Mul_1Mul/gradients/mul_6_grad/tuple/control_dependency_1mul_5/x*
T0
e
%gradients/mul_5_grad/tuple/group_depsNoOp^gradients/mul_5_grad/Mul^gradients/mul_5_grad/Mul_1
?
-gradients/mul_5_grad/tuple/control_dependencyIdentitygradients/mul_5_grad/Mul&^gradients/mul_5_grad/tuple/group_deps*
T0*+
_class!
loc:@gradients/mul_5_grad/Mul
?
/gradients/mul_5_grad/tuple/control_dependency_1Identitygradients/mul_5_grad/Mul_1&^gradients/mul_5_grad/tuple/group_deps*
T0*-
_class#
!loc:@gradients/mul_5_grad/Mul_1
C
gradients/mul_7_grad/ShapeShapeExp_1*
T0*
out_type0
J
gradients/mul_7_grad/Shape_1Shape
advantages*
T0*
out_type0
?
*gradients/mul_7_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/mul_7_grad/Shapegradients/mul_7_grad/Shape_1*
T0
e
gradients/mul_7_grad/MulMul/gradients/Minimum_grad/tuple/control_dependency
advantages*
T0
?
gradients/mul_7_grad/SumSumgradients/mul_7_grad/Mul*gradients/mul_7_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
t
gradients/mul_7_grad/ReshapeReshapegradients/mul_7_grad/Sumgradients/mul_7_grad/Shape*
T0*
Tshape0
b
gradients/mul_7_grad/Mul_1MulExp_1/gradients/Minimum_grad/tuple/control_dependency*
T0
?
gradients/mul_7_grad/Sum_1Sumgradients/mul_7_grad/Mul_1,gradients/mul_7_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
z
gradients/mul_7_grad/Reshape_1Reshapegradients/mul_7_grad/Sum_1gradients/mul_7_grad/Shape_1*
T0*
Tshape0
m
%gradients/mul_7_grad/tuple/group_depsNoOp^gradients/mul_7_grad/Reshape^gradients/mul_7_grad/Reshape_1
?
-gradients/mul_7_grad/tuple/control_dependencyIdentitygradients/mul_7_grad/Reshape&^gradients/mul_7_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/mul_7_grad/Reshape
?
/gradients/mul_7_grad/tuple/control_dependency_1Identitygradients/mul_7_grad/Reshape_1&^gradients/mul_7_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/mul_7_grad/Reshape_1
M
gradients/mul_8_grad/ShapeShapeclip_by_value_2*
T0*
out_type0
J
gradients/mul_8_grad/Shape_1Shape
advantages*
T0*
out_type0
?
*gradients/mul_8_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/mul_8_grad/Shapegradients/mul_8_grad/Shape_1*
T0
g
gradients/mul_8_grad/MulMul1gradients/Minimum_grad/tuple/control_dependency_1
advantages*
T0
?
gradients/mul_8_grad/SumSumgradients/mul_8_grad/Mul*gradients/mul_8_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
t
gradients/mul_8_grad/ReshapeReshapegradients/mul_8_grad/Sumgradients/mul_8_grad/Shape*
T0*
Tshape0
n
gradients/mul_8_grad/Mul_1Mulclip_by_value_21gradients/Minimum_grad/tuple/control_dependency_1*
T0
?
gradients/mul_8_grad/Sum_1Sumgradients/mul_8_grad/Mul_1,gradients/mul_8_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
z
gradients/mul_8_grad/Reshape_1Reshapegradients/mul_8_grad/Sum_1gradients/mul_8_grad/Shape_1*
T0*
Tshape0
m
%gradients/mul_8_grad/tuple/group_depsNoOp^gradients/mul_8_grad/Reshape^gradients/mul_8_grad/Reshape_1
?
-gradients/mul_8_grad/tuple/control_dependencyIdentitygradients/mul_8_grad/Reshape&^gradients/mul_8_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/mul_8_grad/Reshape
?
/gradients/mul_8_grad/tuple/control_dependency_1Identitygradients/mul_8_grad/Reshape_1&^gradients/mul_8_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/mul_8_grad/Reshape_1
\
&gradients/SquaredDifference_grad/ShapeShapediscounted_rewards*
T0*
out_type0
Q
(gradients/SquaredDifference_grad/Shape_1ShapeSum_3*
T0*
out_type0
?
6gradients/SquaredDifference_grad/BroadcastGradientArgsBroadcastGradientArgs&gradients/SquaredDifference_grad/Shape(gradients/SquaredDifference_grad/Shape_1*
T0
?
'gradients/SquaredDifference_grad/scalarConst0^gradients/Maximum_grad/tuple/control_dependency*
valueB
 *   @*
dtype0
?
$gradients/SquaredDifference_grad/mulMul'gradients/SquaredDifference_grad/scalar/gradients/Maximum_grad/tuple/control_dependency*
T0
?
$gradients/SquaredDifference_grad/subSubdiscounted_rewardsSum_30^gradients/Maximum_grad/tuple/control_dependency*
T0
?
&gradients/SquaredDifference_grad/mul_1Mul$gradients/SquaredDifference_grad/mul$gradients/SquaredDifference_grad/sub*
T0
?
$gradients/SquaredDifference_grad/SumSum&gradients/SquaredDifference_grad/mul_16gradients/SquaredDifference_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
?
(gradients/SquaredDifference_grad/ReshapeReshape$gradients/SquaredDifference_grad/Sum&gradients/SquaredDifference_grad/Shape*
T0*
Tshape0
?
&gradients/SquaredDifference_grad/Sum_1Sum&gradients/SquaredDifference_grad/mul_18gradients/SquaredDifference_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
*gradients/SquaredDifference_grad/Reshape_1Reshape&gradients/SquaredDifference_grad/Sum_1(gradients/SquaredDifference_grad/Shape_1*
T0*
Tshape0
`
$gradients/SquaredDifference_grad/NegNeg*gradients/SquaredDifference_grad/Reshape_1*
T0
?
1gradients/SquaredDifference_grad/tuple/group_depsNoOp)^gradients/SquaredDifference_grad/Reshape%^gradients/SquaredDifference_grad/Neg
?
9gradients/SquaredDifference_grad/tuple/control_dependencyIdentity(gradients/SquaredDifference_grad/Reshape2^gradients/SquaredDifference_grad/tuple/group_deps*
T0*;
_class1
/-loc:@gradients/SquaredDifference_grad/Reshape
?
;gradients/SquaredDifference_grad/tuple/control_dependency_1Identity$gradients/SquaredDifference_grad/Neg2^gradients/SquaredDifference_grad/tuple/group_deps*
T0*7
_class-
+)loc:@gradients/SquaredDifference_grad/Neg
^
(gradients/SquaredDifference_1_grad/ShapeShapediscounted_rewards*
T0*
out_type0
S
*gradients/SquaredDifference_1_grad/Shape_1Shapeadd_5*
T0*
out_type0
?
8gradients/SquaredDifference_1_grad/BroadcastGradientArgsBroadcastGradientArgs(gradients/SquaredDifference_1_grad/Shape*gradients/SquaredDifference_1_grad/Shape_1*
T0
?
)gradients/SquaredDifference_1_grad/scalarConst2^gradients/Maximum_grad/tuple/control_dependency_1*
valueB
 *   @*
dtype0
?
&gradients/SquaredDifference_1_grad/mulMul)gradients/SquaredDifference_1_grad/scalar1gradients/Maximum_grad/tuple/control_dependency_1*
T0
?
&gradients/SquaredDifference_1_grad/subSubdiscounted_rewardsadd_52^gradients/Maximum_grad/tuple/control_dependency_1*
T0
?
(gradients/SquaredDifference_1_grad/mul_1Mul&gradients/SquaredDifference_1_grad/mul&gradients/SquaredDifference_1_grad/sub*
T0
?
&gradients/SquaredDifference_1_grad/SumSum(gradients/SquaredDifference_1_grad/mul_18gradients/SquaredDifference_1_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
?
*gradients/SquaredDifference_1_grad/ReshapeReshape&gradients/SquaredDifference_1_grad/Sum(gradients/SquaredDifference_1_grad/Shape*
T0*
Tshape0
?
(gradients/SquaredDifference_1_grad/Sum_1Sum(gradients/SquaredDifference_1_grad/mul_1:gradients/SquaredDifference_1_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
,gradients/SquaredDifference_1_grad/Reshape_1Reshape(gradients/SquaredDifference_1_grad/Sum_1*gradients/SquaredDifference_1_grad/Shape_1*
T0*
Tshape0
d
&gradients/SquaredDifference_1_grad/NegNeg,gradients/SquaredDifference_1_grad/Reshape_1*
T0
?
3gradients/SquaredDifference_1_grad/tuple/group_depsNoOp+^gradients/SquaredDifference_1_grad/Reshape'^gradients/SquaredDifference_1_grad/Neg
?
;gradients/SquaredDifference_1_grad/tuple/control_dependencyIdentity*gradients/SquaredDifference_1_grad/Reshape4^gradients/SquaredDifference_1_grad/tuple/group_deps*
T0*=
_class3
1/loc:@gradients/SquaredDifference_1_grad/Reshape
?
=gradients/SquaredDifference_1_grad/tuple/control_dependency_1Identity&gradients/SquaredDifference_1_grad/Neg4^gradients/SquaredDifference_1_grad/tuple/group_deps*
T0*9
_class/
-+loc:@gradients/SquaredDifference_1_grad/Neg
Q
#gradients/Mean_1_grad/Reshape/shapeConst*
valueB:*
dtype0
?
gradients/Mean_1_grad/ReshapeReshape/gradients/mul_5_grad/tuple/control_dependency_1#gradients/Mean_1_grad/Reshape/shape*
T0*
Tshape0
I
gradients/Mean_1_grad/ConstConst*
valueB:*
dtype0
y
gradients/Mean_1_grad/TileTilegradients/Mean_1_grad/Reshapegradients/Mean_1_grad/Const*
T0*

Tmultiples0
J
gradients/Mean_1_grad/Const_1Const*
valueB
 *   A*
dtype0
l
gradients/Mean_1_grad/truedivRealDivgradients/Mean_1_grad/Tilegradients/Mean_1_grad/Const_1*
T0
_
$gradients/clip_by_value_2_grad/ShapeShapeclip_by_value_2/Minimum*
T0*
out_type0
O
&gradients/clip_by_value_2_grad/Shape_1Const*
valueB *
dtype0
w
&gradients/clip_by_value_2_grad/Shape_2Shape-gradients/mul_8_grad/tuple/control_dependency*
T0*
out_type0
W
*gradients/clip_by_value_2_grad/zeros/ConstConst*
valueB
 *    *
dtype0
?
$gradients/clip_by_value_2_grad/zerosFill&gradients/clip_by_value_2_grad/Shape_2*gradients/clip_by_value_2_grad/zeros/Const*
T0*

index_type0
d
+gradients/clip_by_value_2_grad/GreaterEqualGreaterEqualclip_by_value_2/Minimumsub_9*
T0
?
4gradients/clip_by_value_2_grad/BroadcastGradientArgsBroadcastGradientArgs$gradients/clip_by_value_2_grad/Shape&gradients/clip_by_value_2_grad/Shape_1*
T0
?
%gradients/clip_by_value_2_grad/SelectSelect+gradients/clip_by_value_2_grad/GreaterEqual-gradients/mul_8_grad/tuple/control_dependency$gradients/clip_by_value_2_grad/zeros*
T0
?
'gradients/clip_by_value_2_grad/Select_1Select+gradients/clip_by_value_2_grad/GreaterEqual$gradients/clip_by_value_2_grad/zeros-gradients/mul_8_grad/tuple/control_dependency*
T0
?
"gradients/clip_by_value_2_grad/SumSum%gradients/clip_by_value_2_grad/Select4gradients/clip_by_value_2_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
?
&gradients/clip_by_value_2_grad/ReshapeReshape"gradients/clip_by_value_2_grad/Sum$gradients/clip_by_value_2_grad/Shape*
T0*
Tshape0
?
$gradients/clip_by_value_2_grad/Sum_1Sum'gradients/clip_by_value_2_grad/Select_16gradients/clip_by_value_2_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
(gradients/clip_by_value_2_grad/Reshape_1Reshape$gradients/clip_by_value_2_grad/Sum_1&gradients/clip_by_value_2_grad/Shape_1*
T0*
Tshape0
?
/gradients/clip_by_value_2_grad/tuple/group_depsNoOp'^gradients/clip_by_value_2_grad/Reshape)^gradients/clip_by_value_2_grad/Reshape_1
?
7gradients/clip_by_value_2_grad/tuple/control_dependencyIdentity&gradients/clip_by_value_2_grad/Reshape0^gradients/clip_by_value_2_grad/tuple/group_deps*
T0*9
_class/
-+loc:@gradients/clip_by_value_2_grad/Reshape
?
9gradients/clip_by_value_2_grad/tuple/control_dependency_1Identity(gradients/clip_by_value_2_grad/Reshape_10^gradients/clip_by_value_2_grad/tuple/group_deps*
T0*;
_class1
/-loc:@gradients/clip_by_value_2_grad/Reshape_1
L
gradients/Sum_3_grad/ShapeShapevalue_estimate*
T0*
out_type0
r
gradients/Sum_3_grad/SizeConst*
value	B :*
dtype0*-
_class#
!loc:@gradients/Sum_3_grad/Shape
?
gradients/Sum_3_grad/addAddSum_3/reduction_indicesgradients/Sum_3_grad/Size*
T0*-
_class#
!loc:@gradients/Sum_3_grad/Shape
?
gradients/Sum_3_grad/modFloorModgradients/Sum_3_grad/addgradients/Sum_3_grad/Size*
T0*-
_class#
!loc:@gradients/Sum_3_grad/Shape
t
gradients/Sum_3_grad/Shape_1Const*
valueB *
dtype0*-
_class#
!loc:@gradients/Sum_3_grad/Shape
y
 gradients/Sum_3_grad/range/startConst*
value	B : *
dtype0*-
_class#
!loc:@gradients/Sum_3_grad/Shape
y
 gradients/Sum_3_grad/range/deltaConst*
value	B :*
dtype0*-
_class#
!loc:@gradients/Sum_3_grad/Shape
?
gradients/Sum_3_grad/rangeRange gradients/Sum_3_grad/range/startgradients/Sum_3_grad/Size gradients/Sum_3_grad/range/delta*

Tidx0*-
_class#
!loc:@gradients/Sum_3_grad/Shape
x
gradients/Sum_3_grad/Fill/valueConst*
value	B :*
dtype0*-
_class#
!loc:@gradients/Sum_3_grad/Shape
?
gradients/Sum_3_grad/FillFillgradients/Sum_3_grad/Shape_1gradients/Sum_3_grad/Fill/value*
T0*

index_type0*-
_class#
!loc:@gradients/Sum_3_grad/Shape
?
"gradients/Sum_3_grad/DynamicStitchDynamicStitchgradients/Sum_3_grad/rangegradients/Sum_3_grad/modgradients/Sum_3_grad/Shapegradients/Sum_3_grad/Fill*
T0*
N*-
_class#
!loc:@gradients/Sum_3_grad/Shape
w
gradients/Sum_3_grad/Maximum/yConst*
value	B :*
dtype0*-
_class#
!loc:@gradients/Sum_3_grad/Shape
?
gradients/Sum_3_grad/MaximumMaximum"gradients/Sum_3_grad/DynamicStitchgradients/Sum_3_grad/Maximum/y*
T0*-
_class#
!loc:@gradients/Sum_3_grad/Shape
?
gradients/Sum_3_grad/floordivFloorDivgradients/Sum_3_grad/Shapegradients/Sum_3_grad/Maximum*
T0*-
_class#
!loc:@gradients/Sum_3_grad/Shape
?
gradients/Sum_3_grad/ReshapeReshape;gradients/SquaredDifference_grad/tuple/control_dependency_1"gradients/Sum_3_grad/DynamicStitch*
T0*
Tshape0
y
gradients/Sum_3_grad/TileTilegradients/Sum_3_grad/Reshapegradients/Sum_3_grad/floordiv*
T0*

Tmultiples0
Q
gradients/add_5_grad/ShapeShapeold_value_estimates*
T0*
out_type0
O
gradients/add_5_grad/Shape_1Shapeclip_by_value_1*
T0*
out_type0
?
*gradients/add_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/add_5_grad/Shapegradients/add_5_grad/Shape_1*
T0
?
gradients/add_5_grad/SumSum=gradients/SquaredDifference_1_grad/tuple/control_dependency_1*gradients/add_5_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
t
gradients/add_5_grad/ReshapeReshapegradients/add_5_grad/Sumgradients/add_5_grad/Shape*
T0*
Tshape0
?
gradients/add_5_grad/Sum_1Sum=gradients/SquaredDifference_1_grad/tuple/control_dependency_1,gradients/add_5_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
z
gradients/add_5_grad/Reshape_1Reshapegradients/add_5_grad/Sum_1gradients/add_5_grad/Shape_1*
T0*
Tshape0
m
%gradients/add_5_grad/tuple/group_depsNoOp^gradients/add_5_grad/Reshape^gradients/add_5_grad/Reshape_1
?
-gradients/add_5_grad/tuple/control_dependencyIdentitygradients/add_5_grad/Reshape&^gradients/add_5_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/add_5_grad/Reshape
?
/gradients/add_5_grad/tuple/control_dependency_1Identitygradients/add_5_grad/Reshape_1&^gradients/add_5_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/add_5_grad/Reshape_1
C
gradients/add_4_grad/ShapeConst*
valueB *
dtype0
J
gradients/add_4_grad/Shape_1Const*
valueB:*
dtype0
?
*gradients/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/add_4_grad/Shapegradients/add_4_grad/Shape_1*
T0
?
gradients/add_4_grad/SumSumgradients/Mean_1_grad/truediv*gradients/add_4_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
t
gradients/add_4_grad/ReshapeReshapegradients/add_4_grad/Sumgradients/add_4_grad/Shape*
T0*
Tshape0
?
gradients/add_4_grad/Sum_1Sumgradients/Mean_1_grad/truediv,gradients/add_4_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
z
gradients/add_4_grad/Reshape_1Reshapegradients/add_4_grad/Sum_1gradients/add_4_grad/Shape_1*
T0*
Tshape0
m
%gradients/add_4_grad/tuple/group_depsNoOp^gradients/add_4_grad/Reshape^gradients/add_4_grad/Reshape_1
?
-gradients/add_4_grad/tuple/control_dependencyIdentitygradients/add_4_grad/Reshape&^gradients/add_4_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/add_4_grad/Reshape
?
/gradients/add_4_grad/tuple/control_dependency_1Identitygradients/add_4_grad/Reshape_1&^gradients/add_4_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/add_4_grad/Reshape_1
U
,gradients/clip_by_value_2/Minimum_grad/ShapeShapeExp_1*
T0*
out_type0
W
.gradients/clip_by_value_2/Minimum_grad/Shape_1Const*
valueB *
dtype0
?
.gradients/clip_by_value_2/Minimum_grad/Shape_2Shape7gradients/clip_by_value_2_grad/tuple/control_dependency*
T0*
out_type0
_
2gradients/clip_by_value_2/Minimum_grad/zeros/ConstConst*
valueB
 *    *
dtype0
?
,gradients/clip_by_value_2/Minimum_grad/zerosFill.gradients/clip_by_value_2/Minimum_grad/Shape_22gradients/clip_by_value_2/Minimum_grad/zeros/Const*
T0*

index_type0
T
0gradients/clip_by_value_2/Minimum_grad/LessEqual	LessEqualExp_1add_6*
T0
?
<gradients/clip_by_value_2/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs,gradients/clip_by_value_2/Minimum_grad/Shape.gradients/clip_by_value_2/Minimum_grad/Shape_1*
T0
?
-gradients/clip_by_value_2/Minimum_grad/SelectSelect0gradients/clip_by_value_2/Minimum_grad/LessEqual7gradients/clip_by_value_2_grad/tuple/control_dependency,gradients/clip_by_value_2/Minimum_grad/zeros*
T0
?
/gradients/clip_by_value_2/Minimum_grad/Select_1Select0gradients/clip_by_value_2/Minimum_grad/LessEqual,gradients/clip_by_value_2/Minimum_grad/zeros7gradients/clip_by_value_2_grad/tuple/control_dependency*
T0
?
*gradients/clip_by_value_2/Minimum_grad/SumSum-gradients/clip_by_value_2/Minimum_grad/Select<gradients/clip_by_value_2/Minimum_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
?
.gradients/clip_by_value_2/Minimum_grad/ReshapeReshape*gradients/clip_by_value_2/Minimum_grad/Sum,gradients/clip_by_value_2/Minimum_grad/Shape*
T0*
Tshape0
?
,gradients/clip_by_value_2/Minimum_grad/Sum_1Sum/gradients/clip_by_value_2/Minimum_grad/Select_1>gradients/clip_by_value_2/Minimum_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
0gradients/clip_by_value_2/Minimum_grad/Reshape_1Reshape,gradients/clip_by_value_2/Minimum_grad/Sum_1.gradients/clip_by_value_2/Minimum_grad/Shape_1*
T0*
Tshape0
?
7gradients/clip_by_value_2/Minimum_grad/tuple/group_depsNoOp/^gradients/clip_by_value_2/Minimum_grad/Reshape1^gradients/clip_by_value_2/Minimum_grad/Reshape_1
?
?gradients/clip_by_value_2/Minimum_grad/tuple/control_dependencyIdentity.gradients/clip_by_value_2/Minimum_grad/Reshape8^gradients/clip_by_value_2/Minimum_grad/tuple/group_deps*
T0*A
_class7
53loc:@gradients/clip_by_value_2/Minimum_grad/Reshape
?
Agradients/clip_by_value_2/Minimum_grad/tuple/control_dependency_1Identity0gradients/clip_by_value_2/Minimum_grad/Reshape_18^gradients/clip_by_value_2/Minimum_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/clip_by_value_2/Minimum_grad/Reshape_1
_
$gradients/clip_by_value_1_grad/ShapeShapeclip_by_value_1/Minimum*
T0*
out_type0
O
&gradients/clip_by_value_1_grad/Shape_1Const*
valueB *
dtype0
y
&gradients/clip_by_value_1_grad/Shape_2Shape/gradients/add_5_grad/tuple/control_dependency_1*
T0*
out_type0
W
*gradients/clip_by_value_1_grad/zeros/ConstConst*
valueB
 *    *
dtype0
?
$gradients/clip_by_value_1_grad/zerosFill&gradients/clip_by_value_1_grad/Shape_2*gradients/clip_by_value_1_grad/zeros/Const*
T0*

index_type0
b
+gradients/clip_by_value_1_grad/GreaterEqualGreaterEqualclip_by_value_1/MinimumNeg*
T0
?
4gradients/clip_by_value_1_grad/BroadcastGradientArgsBroadcastGradientArgs$gradients/clip_by_value_1_grad/Shape&gradients/clip_by_value_1_grad/Shape_1*
T0
?
%gradients/clip_by_value_1_grad/SelectSelect+gradients/clip_by_value_1_grad/GreaterEqual/gradients/add_5_grad/tuple/control_dependency_1$gradients/clip_by_value_1_grad/zeros*
T0
?
'gradients/clip_by_value_1_grad/Select_1Select+gradients/clip_by_value_1_grad/GreaterEqual$gradients/clip_by_value_1_grad/zeros/gradients/add_5_grad/tuple/control_dependency_1*
T0
?
"gradients/clip_by_value_1_grad/SumSum%gradients/clip_by_value_1_grad/Select4gradients/clip_by_value_1_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
?
&gradients/clip_by_value_1_grad/ReshapeReshape"gradients/clip_by_value_1_grad/Sum$gradients/clip_by_value_1_grad/Shape*
T0*
Tshape0
?
$gradients/clip_by_value_1_grad/Sum_1Sum'gradients/clip_by_value_1_grad/Select_16gradients/clip_by_value_1_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
(gradients/clip_by_value_1_grad/Reshape_1Reshape$gradients/clip_by_value_1_grad/Sum_1&gradients/clip_by_value_1_grad/Shape_1*
T0*
Tshape0
?
/gradients/clip_by_value_1_grad/tuple/group_depsNoOp'^gradients/clip_by_value_1_grad/Reshape)^gradients/clip_by_value_1_grad/Reshape_1
?
7gradients/clip_by_value_1_grad/tuple/control_dependencyIdentity&gradients/clip_by_value_1_grad/Reshape0^gradients/clip_by_value_1_grad/tuple/group_deps*
T0*9
_class/
-+loc:@gradients/clip_by_value_1_grad/Reshape
?
9gradients/clip_by_value_1_grad/tuple/control_dependency_1Identity(gradients/clip_by_value_1_grad/Reshape_10^gradients/clip_by_value_1_grad/tuple/group_deps*
T0*;
_class1
/-loc:@gradients/clip_by_value_1_grad/Reshape_1
?
gradients/AddNAddN-gradients/mul_7_grad/tuple/control_dependency?gradients/clip_by_value_2/Minimum_grad/tuple/control_dependency*
T0*
N*/
_class%
#!loc:@gradients/mul_7_grad/Reshape
?
gradients/Exp_1_grad/mulMulgradients/AddNExp_1*
T0
U
,gradients/clip_by_value_1/Minimum_grad/ShapeShapesub_7*
T0*
out_type0
W
.gradients/clip_by_value_1/Minimum_grad/Shape_1Const*
valueB *
dtype0
?
.gradients/clip_by_value_1/Minimum_grad/Shape_2Shape7gradients/clip_by_value_1_grad/tuple/control_dependency*
T0*
out_type0
_
2gradients/clip_by_value_1/Minimum_grad/zeros/ConstConst*
valueB
 *    *
dtype0
?
,gradients/clip_by_value_1/Minimum_grad/zerosFill.gradients/clip_by_value_1/Minimum_grad/Shape_22gradients/clip_by_value_1/Minimum_grad/zeros/Const*
T0*

index_type0
`
0gradients/clip_by_value_1/Minimum_grad/LessEqual	LessEqualsub_7PolynomialDecay_1*
T0
?
<gradients/clip_by_value_1/Minimum_grad/BroadcastGradientArgsBroadcastGradientArgs,gradients/clip_by_value_1/Minimum_grad/Shape.gradients/clip_by_value_1/Minimum_grad/Shape_1*
T0
?
-gradients/clip_by_value_1/Minimum_grad/SelectSelect0gradients/clip_by_value_1/Minimum_grad/LessEqual7gradients/clip_by_value_1_grad/tuple/control_dependency,gradients/clip_by_value_1/Minimum_grad/zeros*
T0
?
/gradients/clip_by_value_1/Minimum_grad/Select_1Select0gradients/clip_by_value_1/Minimum_grad/LessEqual,gradients/clip_by_value_1/Minimum_grad/zeros7gradients/clip_by_value_1_grad/tuple/control_dependency*
T0
?
*gradients/clip_by_value_1/Minimum_grad/SumSum-gradients/clip_by_value_1/Minimum_grad/Select<gradients/clip_by_value_1/Minimum_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
?
.gradients/clip_by_value_1/Minimum_grad/ReshapeReshape*gradients/clip_by_value_1/Minimum_grad/Sum,gradients/clip_by_value_1/Minimum_grad/Shape*
T0*
Tshape0
?
,gradients/clip_by_value_1/Minimum_grad/Sum_1Sum/gradients/clip_by_value_1/Minimum_grad/Select_1>gradients/clip_by_value_1/Minimum_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
0gradients/clip_by_value_1/Minimum_grad/Reshape_1Reshape,gradients/clip_by_value_1/Minimum_grad/Sum_1.gradients/clip_by_value_1/Minimum_grad/Shape_1*
T0*
Tshape0
?
7gradients/clip_by_value_1/Minimum_grad/tuple/group_depsNoOp/^gradients/clip_by_value_1/Minimum_grad/Reshape1^gradients/clip_by_value_1/Minimum_grad/Reshape_1
?
?gradients/clip_by_value_1/Minimum_grad/tuple/control_dependencyIdentity.gradients/clip_by_value_1/Minimum_grad/Reshape8^gradients/clip_by_value_1/Minimum_grad/tuple/group_deps*
T0*A
_class7
53loc:@gradients/clip_by_value_1/Minimum_grad/Reshape
?
Agradients/clip_by_value_1/Minimum_grad/tuple/control_dependency_1Identity0gradients/clip_by_value_1/Minimum_grad/Reshape_18^gradients/clip_by_value_1/Minimum_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/clip_by_value_1/Minimum_grad/Reshape_1
A
gradients/sub_8_grad/ShapeShapeSum*
T0*
out_type0
E
gradients/sub_8_grad/Shape_1ShapeSum_1*
T0*
out_type0
?
*gradients/sub_8_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/sub_8_grad/Shapegradients/sub_8_grad/Shape_1*
T0
?
gradients/sub_8_grad/SumSumgradients/Exp_1_grad/mul*gradients/sub_8_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
t
gradients/sub_8_grad/ReshapeReshapegradients/sub_8_grad/Sumgradients/sub_8_grad/Shape*
T0*
Tshape0
?
gradients/sub_8_grad/Sum_1Sumgradients/Exp_1_grad/mul,gradients/sub_8_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
D
gradients/sub_8_grad/NegNeggradients/sub_8_grad/Sum_1*
T0
x
gradients/sub_8_grad/Reshape_1Reshapegradients/sub_8_grad/Neggradients/sub_8_grad/Shape_1*
T0*
Tshape0
m
%gradients/sub_8_grad/tuple/group_depsNoOp^gradients/sub_8_grad/Reshape^gradients/sub_8_grad/Reshape_1
?
-gradients/sub_8_grad/tuple/control_dependencyIdentitygradients/sub_8_grad/Reshape&^gradients/sub_8_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/sub_8_grad/Reshape
?
/gradients/sub_8_grad/tuple/control_dependency_1Identitygradients/sub_8_grad/Reshape_1&^gradients/sub_8_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/sub_8_grad/Reshape_1
C
gradients/sub_7_grad/ShapeShapeSum_2*
T0*
out_type0
S
gradients/sub_7_grad/Shape_1Shapeold_value_estimates*
T0*
out_type0
?
*gradients/sub_7_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/sub_7_grad/Shapegradients/sub_7_grad/Shape_1*
T0
?
gradients/sub_7_grad/SumSum?gradients/clip_by_value_1/Minimum_grad/tuple/control_dependency*gradients/sub_7_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
t
gradients/sub_7_grad/ReshapeReshapegradients/sub_7_grad/Sumgradients/sub_7_grad/Shape*
T0*
Tshape0
?
gradients/sub_7_grad/Sum_1Sum?gradients/clip_by_value_1/Minimum_grad/tuple/control_dependency,gradients/sub_7_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
D
gradients/sub_7_grad/NegNeggradients/sub_7_grad/Sum_1*
T0
x
gradients/sub_7_grad/Reshape_1Reshapegradients/sub_7_grad/Neggradients/sub_7_grad/Shape_1*
T0*
Tshape0
m
%gradients/sub_7_grad/tuple/group_depsNoOp^gradients/sub_7_grad/Reshape^gradients/sub_7_grad/Reshape_1
?
-gradients/sub_7_grad/tuple/control_dependencyIdentitygradients/sub_7_grad/Reshape&^gradients/sub_7_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/sub_7_grad/Reshape
?
/gradients/sub_7_grad/tuple/control_dependency_1Identitygradients/sub_7_grad/Reshape_1&^gradients/sub_7_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/sub_7_grad/Reshape_1
D
gradients/Sum_grad/ShapeShapeIdentity*
T0*
out_type0
n
gradients/Sum_grad/SizeConst*
value	B :*
dtype0*+
_class!
loc:@gradients/Sum_grad/Shape
?
gradients/Sum_grad/addAddSum/reduction_indicesgradients/Sum_grad/Size*
T0*+
_class!
loc:@gradients/Sum_grad/Shape
?
gradients/Sum_grad/modFloorModgradients/Sum_grad/addgradients/Sum_grad/Size*
T0*+
_class!
loc:@gradients/Sum_grad/Shape
p
gradients/Sum_grad/Shape_1Const*
valueB *
dtype0*+
_class!
loc:@gradients/Sum_grad/Shape
u
gradients/Sum_grad/range/startConst*
value	B : *
dtype0*+
_class!
loc:@gradients/Sum_grad/Shape
u
gradients/Sum_grad/range/deltaConst*
value	B :*
dtype0*+
_class!
loc:@gradients/Sum_grad/Shape
?
gradients/Sum_grad/rangeRangegradients/Sum_grad/range/startgradients/Sum_grad/Sizegradients/Sum_grad/range/delta*

Tidx0*+
_class!
loc:@gradients/Sum_grad/Shape
t
gradients/Sum_grad/Fill/valueConst*
value	B :*
dtype0*+
_class!
loc:@gradients/Sum_grad/Shape
?
gradients/Sum_grad/FillFillgradients/Sum_grad/Shape_1gradients/Sum_grad/Fill/value*
T0*

index_type0*+
_class!
loc:@gradients/Sum_grad/Shape
?
 gradients/Sum_grad/DynamicStitchDynamicStitchgradients/Sum_grad/rangegradients/Sum_grad/modgradients/Sum_grad/Shapegradients/Sum_grad/Fill*
T0*
N*+
_class!
loc:@gradients/Sum_grad/Shape
s
gradients/Sum_grad/Maximum/yConst*
value	B :*
dtype0*+
_class!
loc:@gradients/Sum_grad/Shape
?
gradients/Sum_grad/MaximumMaximum gradients/Sum_grad/DynamicStitchgradients/Sum_grad/Maximum/y*
T0*+
_class!
loc:@gradients/Sum_grad/Shape
?
gradients/Sum_grad/floordivFloorDivgradients/Sum_grad/Shapegradients/Sum_grad/Maximum*
T0*+
_class!
loc:@gradients/Sum_grad/Shape
?
gradients/Sum_grad/ReshapeReshape-gradients/sub_8_grad/tuple/control_dependency gradients/Sum_grad/DynamicStitch*
T0*
Tshape0
s
gradients/Sum_grad/TileTilegradients/Sum_grad/Reshapegradients/Sum_grad/floordiv*
T0*

Tmultiples0
L
gradients/Sum_2_grad/ShapeShapevalue_estimate*
T0*
out_type0
r
gradients/Sum_2_grad/SizeConst*
value	B :*
dtype0*-
_class#
!loc:@gradients/Sum_2_grad/Shape
?
gradients/Sum_2_grad/addAddSum_2/reduction_indicesgradients/Sum_2_grad/Size*
T0*-
_class#
!loc:@gradients/Sum_2_grad/Shape
?
gradients/Sum_2_grad/modFloorModgradients/Sum_2_grad/addgradients/Sum_2_grad/Size*
T0*-
_class#
!loc:@gradients/Sum_2_grad/Shape
t
gradients/Sum_2_grad/Shape_1Const*
valueB *
dtype0*-
_class#
!loc:@gradients/Sum_2_grad/Shape
y
 gradients/Sum_2_grad/range/startConst*
value	B : *
dtype0*-
_class#
!loc:@gradients/Sum_2_grad/Shape
y
 gradients/Sum_2_grad/range/deltaConst*
value	B :*
dtype0*-
_class#
!loc:@gradients/Sum_2_grad/Shape
?
gradients/Sum_2_grad/rangeRange gradients/Sum_2_grad/range/startgradients/Sum_2_grad/Size gradients/Sum_2_grad/range/delta*

Tidx0*-
_class#
!loc:@gradients/Sum_2_grad/Shape
x
gradients/Sum_2_grad/Fill/valueConst*
value	B :*
dtype0*-
_class#
!loc:@gradients/Sum_2_grad/Shape
?
gradients/Sum_2_grad/FillFillgradients/Sum_2_grad/Shape_1gradients/Sum_2_grad/Fill/value*
T0*

index_type0*-
_class#
!loc:@gradients/Sum_2_grad/Shape
?
"gradients/Sum_2_grad/DynamicStitchDynamicStitchgradients/Sum_2_grad/rangegradients/Sum_2_grad/modgradients/Sum_2_grad/Shapegradients/Sum_2_grad/Fill*
T0*
N*-
_class#
!loc:@gradients/Sum_2_grad/Shape
w
gradients/Sum_2_grad/Maximum/yConst*
value	B :*
dtype0*-
_class#
!loc:@gradients/Sum_2_grad/Shape
?
gradients/Sum_2_grad/MaximumMaximum"gradients/Sum_2_grad/DynamicStitchgradients/Sum_2_grad/Maximum/y*
T0*-
_class#
!loc:@gradients/Sum_2_grad/Shape
?
gradients/Sum_2_grad/floordivFloorDivgradients/Sum_2_grad/Shapegradients/Sum_2_grad/Maximum*
T0*-
_class#
!loc:@gradients/Sum_2_grad/Shape
?
gradients/Sum_2_grad/ReshapeReshape-gradients/sub_7_grad/tuple/control_dependency"gradients/Sum_2_grad/DynamicStitch*
T0*
Tshape0
y
gradients/Sum_2_grad/TileTilegradients/Sum_2_grad/Reshapegradients/Sum_2_grad/floordiv*
T0*

Tmultiples0
?
gradients/AddN_1AddNgradients/Sum_3_grad/Tilegradients/Sum_2_grad/Tile*
T0*
N*,
_class"
 loc:@gradients/Sum_3_grad/Tile
k
*gradients/dense_1/BiasAdd_grad/BiasAddGradBiasAddGradgradients/AddN_1*
T0*
data_formatNHWC
w
/gradients/dense_1/BiasAdd_grad/tuple/group_depsNoOp^gradients/AddN_1+^gradients/dense_1/BiasAdd_grad/BiasAddGrad
?
7gradients/dense_1/BiasAdd_grad/tuple/control_dependencyIdentitygradients/AddN_10^gradients/dense_1/BiasAdd_grad/tuple/group_deps*
T0*,
_class"
 loc:@gradients/Sum_3_grad/Tile
?
9gradients/dense_1/BiasAdd_grad/tuple/control_dependency_1Identity*gradients/dense_1/BiasAdd_grad/BiasAddGrad0^gradients/dense_1/BiasAdd_grad/tuple/group_deps*
T0*=
_class3
1/loc:@gradients/dense_1/BiasAdd_grad/BiasAddGrad
C
gradients/sub_6_grad/ShapeShapesub_5*
T0*
out_type0
J
gradients/sub_6_grad/Shape_1Const*
valueB:*
dtype0
?
*gradients/sub_6_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/sub_6_grad/Shapegradients/sub_6_grad/Shape_1*
T0
?
gradients/sub_6_grad/SumSumgradients/Sum_grad/Tile*gradients/sub_6_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
t
gradients/sub_6_grad/ReshapeReshapegradients/sub_6_grad/Sumgradients/sub_6_grad/Shape*
T0*
Tshape0
?
gradients/sub_6_grad/Sum_1Sumgradients/Sum_grad/Tile,gradients/sub_6_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
D
gradients/sub_6_grad/NegNeggradients/sub_6_grad/Sum_1*
T0
x
gradients/sub_6_grad/Reshape_1Reshapegradients/sub_6_grad/Neggradients/sub_6_grad/Shape_1*
T0*
Tshape0
m
%gradients/sub_6_grad/tuple/group_depsNoOp^gradients/sub_6_grad/Reshape^gradients/sub_6_grad/Reshape_1
?
-gradients/sub_6_grad/tuple/control_dependencyIdentitygradients/sub_6_grad/Reshape&^gradients/sub_6_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/sub_6_grad/Reshape
?
/gradients/sub_6_grad/tuple/control_dependency_1Identitygradients/sub_6_grad/Reshape_1&^gradients/sub_6_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/sub_6_grad/Reshape_1
?
$gradients/dense_1/MatMul_grad/MatMulMatMul7gradients/dense_1/BiasAdd_grad/tuple/control_dependencydense_1/kernel/read*
transpose_b(*
T0*
transpose_a( 
?
&gradients/dense_1/MatMul_grad/MatMul_1MatMulmain_graph_1/hidden_2/Mul7gradients/dense_1/BiasAdd_grad/tuple/control_dependency*
transpose_b( *
T0*
transpose_a(
?
.gradients/dense_1/MatMul_grad/tuple/group_depsNoOp%^gradients/dense_1/MatMul_grad/MatMul'^gradients/dense_1/MatMul_grad/MatMul_1
?
6gradients/dense_1/MatMul_grad/tuple/control_dependencyIdentity$gradients/dense_1/MatMul_grad/MatMul/^gradients/dense_1/MatMul_grad/tuple/group_deps*
T0*7
_class-
+)loc:@gradients/dense_1/MatMul_grad/MatMul
?
8gradients/dense_1/MatMul_grad/tuple/control_dependency_1Identity&gradients/dense_1/MatMul_grad/MatMul_1/^gradients/dense_1/MatMul_grad/tuple/group_deps*
T0*9
_class/
-+loc:@gradients/dense_1/MatMul_grad/MatMul_1
G
gradients/sub_5_grad/ShapeShape	truediv_4*
T0*
out_type0
E
gradients/sub_5_grad/Shape_1Const*
valueB *
dtype0
?
*gradients/sub_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/sub_5_grad/Shapegradients/sub_5_grad/Shape_1*
T0
?
gradients/sub_5_grad/SumSum-gradients/sub_6_grad/tuple/control_dependency*gradients/sub_5_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
t
gradients/sub_5_grad/ReshapeReshapegradients/sub_5_grad/Sumgradients/sub_5_grad/Shape*
T0*
Tshape0
?
gradients/sub_5_grad/Sum_1Sum-gradients/sub_6_grad/tuple/control_dependency,gradients/sub_5_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
D
gradients/sub_5_grad/NegNeggradients/sub_5_grad/Sum_1*
T0
x
gradients/sub_5_grad/Reshape_1Reshapegradients/sub_5_grad/Neggradients/sub_5_grad/Shape_1*
T0*
Tshape0
m
%gradients/sub_5_grad/tuple/group_depsNoOp^gradients/sub_5_grad/Reshape^gradients/sub_5_grad/Reshape_1
?
-gradients/sub_5_grad/tuple/control_dependencyIdentitygradients/sub_5_grad/Reshape&^gradients/sub_5_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/sub_5_grad/Reshape
?
/gradients/sub_5_grad/tuple/control_dependency_1Identitygradients/sub_5_grad/Reshape_1&^gradients/sub_5_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/sub_5_grad/Reshape_1
C
gradients/mul_4_grad/ShapeConst*
valueB *
dtype0
J
gradients/mul_4_grad/Shape_1Const*
valueB:*
dtype0
?
*gradients/mul_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/mul_4_grad/Shapegradients/mul_4_grad/Shape_1*
T0
q
gradients/mul_4_grad/MulMul/gradients/sub_6_grad/tuple/control_dependency_1log_sigma_squared/read*
T0
?
gradients/mul_4_grad/SumSumgradients/mul_4_grad/Mul*gradients/mul_4_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
t
gradients/mul_4_grad/ReshapeReshapegradients/mul_4_grad/Sumgradients/mul_4_grad/Shape*
T0*
Tshape0
d
gradients/mul_4_grad/Mul_1Mulmul_4/x/gradients/sub_6_grad/tuple/control_dependency_1*
T0
?
gradients/mul_4_grad/Sum_1Sumgradients/mul_4_grad/Mul_1,gradients/mul_4_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
z
gradients/mul_4_grad/Reshape_1Reshapegradients/mul_4_grad/Sum_1gradients/mul_4_grad/Shape_1*
T0*
Tshape0
m
%gradients/mul_4_grad/tuple/group_depsNoOp^gradients/mul_4_grad/Reshape^gradients/mul_4_grad/Reshape_1
?
-gradients/mul_4_grad/tuple/control_dependencyIdentitygradients/mul_4_grad/Reshape&^gradients/mul_4_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/mul_4_grad/Reshape
?
/gradients/mul_4_grad/tuple/control_dependency_1Identitygradients/mul_4_grad/Reshape_1&^gradients/mul_4_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/mul_4_grad/Reshape_1
o
.gradients/main_graph_1/hidden_2/Mul_grad/ShapeShapemain_graph_1/hidden_2/BiasAdd*
T0*
out_type0
q
0gradients/main_graph_1/hidden_2/Mul_grad/Shape_1Shapemain_graph_1/hidden_2/Sigmoid*
T0*
out_type0
?
>gradients/main_graph_1/hidden_2/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs.gradients/main_graph_1/hidden_2/Mul_grad/Shape0gradients/main_graph_1/hidden_2/Mul_grad/Shape_1*
T0
?
,gradients/main_graph_1/hidden_2/Mul_grad/MulMul6gradients/dense_1/MatMul_grad/tuple/control_dependencymain_graph_1/hidden_2/Sigmoid*
T0
?
,gradients/main_graph_1/hidden_2/Mul_grad/SumSum,gradients/main_graph_1/hidden_2/Mul_grad/Mul>gradients/main_graph_1/hidden_2/Mul_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
?
0gradients/main_graph_1/hidden_2/Mul_grad/ReshapeReshape,gradients/main_graph_1/hidden_2/Mul_grad/Sum.gradients/main_graph_1/hidden_2/Mul_grad/Shape*
T0*
Tshape0
?
.gradients/main_graph_1/hidden_2/Mul_grad/Mul_1Mulmain_graph_1/hidden_2/BiasAdd6gradients/dense_1/MatMul_grad/tuple/control_dependency*
T0
?
.gradients/main_graph_1/hidden_2/Mul_grad/Sum_1Sum.gradients/main_graph_1/hidden_2/Mul_grad/Mul_1@gradients/main_graph_1/hidden_2/Mul_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
2gradients/main_graph_1/hidden_2/Mul_grad/Reshape_1Reshape.gradients/main_graph_1/hidden_2/Mul_grad/Sum_10gradients/main_graph_1/hidden_2/Mul_grad/Shape_1*
T0*
Tshape0
?
9gradients/main_graph_1/hidden_2/Mul_grad/tuple/group_depsNoOp1^gradients/main_graph_1/hidden_2/Mul_grad/Reshape3^gradients/main_graph_1/hidden_2/Mul_grad/Reshape_1
?
Agradients/main_graph_1/hidden_2/Mul_grad/tuple/control_dependencyIdentity0gradients/main_graph_1/hidden_2/Mul_grad/Reshape:^gradients/main_graph_1/hidden_2/Mul_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/main_graph_1/hidden_2/Mul_grad/Reshape
?
Cgradients/main_graph_1/hidden_2/Mul_grad/tuple/control_dependency_1Identity2gradients/main_graph_1/hidden_2/Mul_grad/Reshape_1:^gradients/main_graph_1/hidden_2/Mul_grad/tuple/group_deps*
T0*E
_class;
97loc:@gradients/main_graph_1/hidden_2/Mul_grad/Reshape_1
G
gradients/truediv_4_grad/ShapeShapemul_2*
T0*
out_type0
N
 gradients/truediv_4_grad/Shape_1Const*
valueB:*
dtype0
?
.gradients/truediv_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/truediv_4_grad/Shape gradients/truediv_4_grad/Shape_1*
T0
h
 gradients/truediv_4_grad/RealDivRealDiv-gradients/sub_5_grad/tuple/control_dependencyExp*
T0
?
gradients/truediv_4_grad/SumSum gradients/truediv_4_grad/RealDiv.gradients/truediv_4_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
?
 gradients/truediv_4_grad/ReshapeReshapegradients/truediv_4_grad/Sumgradients/truediv_4_grad/Shape*
T0*
Tshape0
3
gradients/truediv_4_grad/NegNegmul_2*
T0
Y
"gradients/truediv_4_grad/RealDiv_1RealDivgradients/truediv_4_grad/NegExp*
T0
_
"gradients/truediv_4_grad/RealDiv_2RealDiv"gradients/truediv_4_grad/RealDiv_1Exp*
T0

gradients/truediv_4_grad/mulMul-gradients/sub_5_grad/tuple/control_dependency"gradients/truediv_4_grad/RealDiv_2*
T0
?
gradients/truediv_4_grad/Sum_1Sumgradients/truediv_4_grad/mul0gradients/truediv_4_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
"gradients/truediv_4_grad/Reshape_1Reshapegradients/truediv_4_grad/Sum_1 gradients/truediv_4_grad/Shape_1*
T0*
Tshape0
y
)gradients/truediv_4_grad/tuple/group_depsNoOp!^gradients/truediv_4_grad/Reshape#^gradients/truediv_4_grad/Reshape_1
?
1gradients/truediv_4_grad/tuple/control_dependencyIdentity gradients/truediv_4_grad/Reshape*^gradients/truediv_4_grad/tuple/group_deps*
T0*3
_class)
'%loc:@gradients/truediv_4_grad/Reshape
?
3gradients/truediv_4_grad/tuple/control_dependency_1Identity"gradients/truediv_4_grad/Reshape_1*^gradients/truediv_4_grad/tuple/group_deps*
T0*5
_class+
)'loc:@gradients/truediv_4_grad/Reshape_1
?
8gradients/main_graph_1/hidden_2/Sigmoid_grad/SigmoidGradSigmoidGradmain_graph_1/hidden_2/SigmoidCgradients/main_graph_1/hidden_2/Mul_grad/tuple/control_dependency_1*
T0
C
gradients/mul_2_grad/ShapeConst*
valueB *
dtype0
F
gradients/mul_2_grad/Shape_1ShapeSquare*
T0*
out_type0
?
*gradients/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/mul_2_grad/Shapegradients/mul_2_grad/Shape_1*
T0
c
gradients/mul_2_grad/MulMul1gradients/truediv_4_grad/tuple/control_dependencySquare*
T0
?
gradients/mul_2_grad/SumSumgradients/mul_2_grad/Mul*gradients/mul_2_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
t
gradients/mul_2_grad/ReshapeReshapegradients/mul_2_grad/Sumgradients/mul_2_grad/Shape*
T0*
Tshape0
f
gradients/mul_2_grad/Mul_1Mulmul_2/x1gradients/truediv_4_grad/tuple/control_dependency*
T0
?
gradients/mul_2_grad/Sum_1Sumgradients/mul_2_grad/Mul_1,gradients/mul_2_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
z
gradients/mul_2_grad/Reshape_1Reshapegradients/mul_2_grad/Sum_1gradients/mul_2_grad/Shape_1*
T0*
Tshape0
m
%gradients/mul_2_grad/tuple/group_depsNoOp^gradients/mul_2_grad/Reshape^gradients/mul_2_grad/Reshape_1
?
-gradients/mul_2_grad/tuple/control_dependencyIdentitygradients/mul_2_grad/Reshape&^gradients/mul_2_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/mul_2_grad/Reshape
?
/gradients/mul_2_grad/tuple/control_dependency_1Identitygradients/mul_2_grad/Reshape_1&^gradients/mul_2_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/mul_2_grad/Reshape_1
?
gradients/AddN_2AddNAgradients/main_graph_1/hidden_2/Mul_grad/tuple/control_dependency8gradients/main_graph_1/hidden_2/Sigmoid_grad/SigmoidGrad*
T0*
N*C
_class9
75loc:@gradients/main_graph_1/hidden_2/Mul_grad/Reshape
y
8gradients/main_graph_1/hidden_2/BiasAdd_grad/BiasAddGradBiasAddGradgradients/AddN_2*
T0*
data_formatNHWC
?
=gradients/main_graph_1/hidden_2/BiasAdd_grad/tuple/group_depsNoOp^gradients/AddN_29^gradients/main_graph_1/hidden_2/BiasAdd_grad/BiasAddGrad
?
Egradients/main_graph_1/hidden_2/BiasAdd_grad/tuple/control_dependencyIdentitygradients/AddN_2>^gradients/main_graph_1/hidden_2/BiasAdd_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/main_graph_1/hidden_2/Mul_grad/Reshape
?
Ggradients/main_graph_1/hidden_2/BiasAdd_grad/tuple/control_dependency_1Identity8gradients/main_graph_1/hidden_2/BiasAdd_grad/BiasAddGrad>^gradients/main_graph_1/hidden_2/BiasAdd_grad/tuple/group_deps*
T0*K
_classA
?=loc:@gradients/main_graph_1/hidden_2/BiasAdd_grad/BiasAddGrad
z
gradients/Square_grad/ConstConst0^gradients/mul_2_grad/tuple/control_dependency_1*
valueB
 *   @*
dtype0
M
gradients/Square_grad/MulMulsub_4gradients/Square_grad/Const*
T0
w
gradients/Square_grad/Mul_1Mul/gradients/mul_2_grad/tuple/control_dependency_1gradients/Square_grad/Mul*
T0
?
2gradients/main_graph_1/hidden_2/MatMul_grad/MatMulMatMulEgradients/main_graph_1/hidden_2/BiasAdd_grad/tuple/control_dependency!main_graph_1/hidden_2/kernel/read*
transpose_b(*
T0*
transpose_a( 
?
4gradients/main_graph_1/hidden_2/MatMul_grad/MatMul_1MatMulmain_graph_1/hidden_1/MulEgradients/main_graph_1/hidden_2/BiasAdd_grad/tuple/control_dependency*
transpose_b( *
T0*
transpose_a(
?
<gradients/main_graph_1/hidden_2/MatMul_grad/tuple/group_depsNoOp3^gradients/main_graph_1/hidden_2/MatMul_grad/MatMul5^gradients/main_graph_1/hidden_2/MatMul_grad/MatMul_1
?
Dgradients/main_graph_1/hidden_2/MatMul_grad/tuple/control_dependencyIdentity2gradients/main_graph_1/hidden_2/MatMul_grad/MatMul=^gradients/main_graph_1/hidden_2/MatMul_grad/tuple/group_deps*
T0*E
_class;
97loc:@gradients/main_graph_1/hidden_2/MatMul_grad/MatMul
?
Fgradients/main_graph_1/hidden_2/MatMul_grad/tuple/control_dependency_1Identity4gradients/main_graph_1/hidden_2/MatMul_grad/MatMul_1=^gradients/main_graph_1/hidden_2/MatMul_grad/tuple/group_deps*
T0*G
_class=
;9loc:@gradients/main_graph_1/hidden_2/MatMul_grad/MatMul_1
L
gradients/sub_4_grad/ShapeShapeStopGradient_1*
T0*
out_type0
M
gradients/sub_4_grad/Shape_1Shapedense/BiasAdd*
T0*
out_type0
?
*gradients/sub_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/sub_4_grad/Shapegradients/sub_4_grad/Shape_1*
T0
?
gradients/sub_4_grad/SumSumgradients/Square_grad/Mul_1*gradients/sub_4_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
t
gradients/sub_4_grad/ReshapeReshapegradients/sub_4_grad/Sumgradients/sub_4_grad/Shape*
T0*
Tshape0
?
gradients/sub_4_grad/Sum_1Sumgradients/Square_grad/Mul_1,gradients/sub_4_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
D
gradients/sub_4_grad/NegNeggradients/sub_4_grad/Sum_1*
T0
x
gradients/sub_4_grad/Reshape_1Reshapegradients/sub_4_grad/Neggradients/sub_4_grad/Shape_1*
T0*
Tshape0
m
%gradients/sub_4_grad/tuple/group_depsNoOp^gradients/sub_4_grad/Reshape^gradients/sub_4_grad/Reshape_1
?
-gradients/sub_4_grad/tuple/control_dependencyIdentitygradients/sub_4_grad/Reshape&^gradients/sub_4_grad/tuple/group_deps*
T0*/
_class%
#!loc:@gradients/sub_4_grad/Reshape
?
/gradients/sub_4_grad/tuple/control_dependency_1Identitygradients/sub_4_grad/Reshape_1&^gradients/sub_4_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/sub_4_grad/Reshape_1
o
.gradients/main_graph_1/hidden_1/Mul_grad/ShapeShapemain_graph_1/hidden_1/BiasAdd*
T0*
out_type0
q
0gradients/main_graph_1/hidden_1/Mul_grad/Shape_1Shapemain_graph_1/hidden_1/Sigmoid*
T0*
out_type0
?
>gradients/main_graph_1/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs.gradients/main_graph_1/hidden_1/Mul_grad/Shape0gradients/main_graph_1/hidden_1/Mul_grad/Shape_1*
T0
?
,gradients/main_graph_1/hidden_1/Mul_grad/MulMulDgradients/main_graph_1/hidden_2/MatMul_grad/tuple/control_dependencymain_graph_1/hidden_1/Sigmoid*
T0
?
,gradients/main_graph_1/hidden_1/Mul_grad/SumSum,gradients/main_graph_1/hidden_1/Mul_grad/Mul>gradients/main_graph_1/hidden_1/Mul_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
?
0gradients/main_graph_1/hidden_1/Mul_grad/ReshapeReshape,gradients/main_graph_1/hidden_1/Mul_grad/Sum.gradients/main_graph_1/hidden_1/Mul_grad/Shape*
T0*
Tshape0
?
.gradients/main_graph_1/hidden_1/Mul_grad/Mul_1Mulmain_graph_1/hidden_1/BiasAddDgradients/main_graph_1/hidden_2/MatMul_grad/tuple/control_dependency*
T0
?
.gradients/main_graph_1/hidden_1/Mul_grad/Sum_1Sum.gradients/main_graph_1/hidden_1/Mul_grad/Mul_1@gradients/main_graph_1/hidden_1/Mul_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
2gradients/main_graph_1/hidden_1/Mul_grad/Reshape_1Reshape.gradients/main_graph_1/hidden_1/Mul_grad/Sum_10gradients/main_graph_1/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
?
9gradients/main_graph_1/hidden_1/Mul_grad/tuple/group_depsNoOp1^gradients/main_graph_1/hidden_1/Mul_grad/Reshape3^gradients/main_graph_1/hidden_1/Mul_grad/Reshape_1
?
Agradients/main_graph_1/hidden_1/Mul_grad/tuple/control_dependencyIdentity0gradients/main_graph_1/hidden_1/Mul_grad/Reshape:^gradients/main_graph_1/hidden_1/Mul_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/main_graph_1/hidden_1/Mul_grad/Reshape
?
Cgradients/main_graph_1/hidden_1/Mul_grad/tuple/control_dependency_1Identity2gradients/main_graph_1/hidden_1/Mul_grad/Reshape_1:^gradients/main_graph_1/hidden_1/Mul_grad/tuple/group_deps*
T0*E
_class;
97loc:@gradients/main_graph_1/hidden_1/Mul_grad/Reshape_1
?
8gradients/main_graph_1/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGradmain_graph_1/hidden_1/SigmoidCgradients/main_graph_1/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
?
gradients/AddN_3AddNAgradients/main_graph_1/hidden_1/Mul_grad/tuple/control_dependency8gradients/main_graph_1/hidden_1/Sigmoid_grad/SigmoidGrad*
T0*
N*C
_class9
75loc:@gradients/main_graph_1/hidden_1/Mul_grad/Reshape
y
8gradients/main_graph_1/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradgradients/AddN_3*
T0*
data_formatNHWC
?
=gradients/main_graph_1/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^gradients/AddN_39^gradients/main_graph_1/hidden_1/BiasAdd_grad/BiasAddGrad
?
Egradients/main_graph_1/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentitygradients/AddN_3>^gradients/main_graph_1/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/main_graph_1/hidden_1/Mul_grad/Reshape
?
Ggradients/main_graph_1/hidden_1/BiasAdd_grad/tuple/control_dependency_1Identity8gradients/main_graph_1/hidden_1/BiasAdd_grad/BiasAddGrad>^gradients/main_graph_1/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*K
_classA
?=loc:@gradients/main_graph_1/hidden_1/BiasAdd_grad/BiasAddGrad
?
2gradients/main_graph_1/hidden_1/MatMul_grad/MatMulMatMulEgradients/main_graph_1/hidden_1/BiasAdd_grad/tuple/control_dependency!main_graph_1/hidden_1/kernel/read*
transpose_b(*
T0*
transpose_a( 
?
4gradients/main_graph_1/hidden_1/MatMul_grad/MatMul_1MatMulmain_graph_1/hidden_0/MulEgradients/main_graph_1/hidden_1/BiasAdd_grad/tuple/control_dependency*
transpose_b( *
T0*
transpose_a(
?
<gradients/main_graph_1/hidden_1/MatMul_grad/tuple/group_depsNoOp3^gradients/main_graph_1/hidden_1/MatMul_grad/MatMul5^gradients/main_graph_1/hidden_1/MatMul_grad/MatMul_1
?
Dgradients/main_graph_1/hidden_1/MatMul_grad/tuple/control_dependencyIdentity2gradients/main_graph_1/hidden_1/MatMul_grad/MatMul=^gradients/main_graph_1/hidden_1/MatMul_grad/tuple/group_deps*
T0*E
_class;
97loc:@gradients/main_graph_1/hidden_1/MatMul_grad/MatMul
?
Fgradients/main_graph_1/hidden_1/MatMul_grad/tuple/control_dependency_1Identity4gradients/main_graph_1/hidden_1/MatMul_grad/MatMul_1=^gradients/main_graph_1/hidden_1/MatMul_grad/tuple/group_deps*
T0*G
_class=
;9loc:@gradients/main_graph_1/hidden_1/MatMul_grad/MatMul_1
o
.gradients/main_graph_1/hidden_0/Mul_grad/ShapeShapemain_graph_1/hidden_0/BiasAdd*
T0*
out_type0
q
0gradients/main_graph_1/hidden_0/Mul_grad/Shape_1Shapemain_graph_1/hidden_0/Sigmoid*
T0*
out_type0
?
>gradients/main_graph_1/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs.gradients/main_graph_1/hidden_0/Mul_grad/Shape0gradients/main_graph_1/hidden_0/Mul_grad/Shape_1*
T0
?
,gradients/main_graph_1/hidden_0/Mul_grad/MulMulDgradients/main_graph_1/hidden_1/MatMul_grad/tuple/control_dependencymain_graph_1/hidden_0/Sigmoid*
T0
?
,gradients/main_graph_1/hidden_0/Mul_grad/SumSum,gradients/main_graph_1/hidden_0/Mul_grad/Mul>gradients/main_graph_1/hidden_0/Mul_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
?
0gradients/main_graph_1/hidden_0/Mul_grad/ReshapeReshape,gradients/main_graph_1/hidden_0/Mul_grad/Sum.gradients/main_graph_1/hidden_0/Mul_grad/Shape*
T0*
Tshape0
?
.gradients/main_graph_1/hidden_0/Mul_grad/Mul_1Mulmain_graph_1/hidden_0/BiasAddDgradients/main_graph_1/hidden_1/MatMul_grad/tuple/control_dependency*
T0
?
.gradients/main_graph_1/hidden_0/Mul_grad/Sum_1Sum.gradients/main_graph_1/hidden_0/Mul_grad/Mul_1@gradients/main_graph_1/hidden_0/Mul_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
2gradients/main_graph_1/hidden_0/Mul_grad/Reshape_1Reshape.gradients/main_graph_1/hidden_0/Mul_grad/Sum_10gradients/main_graph_1/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
?
9gradients/main_graph_1/hidden_0/Mul_grad/tuple/group_depsNoOp1^gradients/main_graph_1/hidden_0/Mul_grad/Reshape3^gradients/main_graph_1/hidden_0/Mul_grad/Reshape_1
?
Agradients/main_graph_1/hidden_0/Mul_grad/tuple/control_dependencyIdentity0gradients/main_graph_1/hidden_0/Mul_grad/Reshape:^gradients/main_graph_1/hidden_0/Mul_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/main_graph_1/hidden_0/Mul_grad/Reshape
?
Cgradients/main_graph_1/hidden_0/Mul_grad/tuple/control_dependency_1Identity2gradients/main_graph_1/hidden_0/Mul_grad/Reshape_1:^gradients/main_graph_1/hidden_0/Mul_grad/tuple/group_deps*
T0*E
_class;
97loc:@gradients/main_graph_1/hidden_0/Mul_grad/Reshape_1
`
gradients/Exp_grad/mulMul3gradients/truediv_4_grad/tuple/control_dependency_1Exp*
T0
?
8gradients/main_graph_1/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGradmain_graph_1/hidden_0/SigmoidCgradients/main_graph_1/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
?
gradients/AddN_4AddN/gradients/add_4_grad/tuple/control_dependency_1/gradients/mul_4_grad/tuple/control_dependency_1gradients/Exp_grad/mul*
T0*
N*1
_class'
%#loc:@gradients/add_4_grad/Reshape_1
?
gradients/AddN_5AddNAgradients/main_graph_1/hidden_0/Mul_grad/tuple/control_dependency8gradients/main_graph_1/hidden_0/Sigmoid_grad/SigmoidGrad*
T0*
N*C
_class9
75loc:@gradients/main_graph_1/hidden_0/Mul_grad/Reshape
y
8gradients/main_graph_1/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradgradients/AddN_5*
T0*
data_formatNHWC
?
=gradients/main_graph_1/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^gradients/AddN_59^gradients/main_graph_1/hidden_0/BiasAdd_grad/BiasAddGrad
?
Egradients/main_graph_1/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentitygradients/AddN_5>^gradients/main_graph_1/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/main_graph_1/hidden_0/Mul_grad/Reshape
?
Ggradients/main_graph_1/hidden_0/BiasAdd_grad/tuple/control_dependency_1Identity8gradients/main_graph_1/hidden_0/BiasAdd_grad/BiasAddGrad>^gradients/main_graph_1/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*K
_classA
?=loc:@gradients/main_graph_1/hidden_0/BiasAdd_grad/BiasAddGrad
?
2gradients/main_graph_1/hidden_0/MatMul_grad/MatMulMatMulEgradients/main_graph_1/hidden_0/BiasAdd_grad/tuple/control_dependency!main_graph_1/hidden_0/kernel/read*
transpose_b(*
T0*
transpose_a( 
?
4gradients/main_graph_1/hidden_0/MatMul_grad/MatMul_1MatMulnormalized_stateEgradients/main_graph_1/hidden_0/BiasAdd_grad/tuple/control_dependency*
transpose_b( *
T0*
transpose_a(
?
<gradients/main_graph_1/hidden_0/MatMul_grad/tuple/group_depsNoOp3^gradients/main_graph_1/hidden_0/MatMul_grad/MatMul5^gradients/main_graph_1/hidden_0/MatMul_grad/MatMul_1
?
Dgradients/main_graph_1/hidden_0/MatMul_grad/tuple/control_dependencyIdentity2gradients/main_graph_1/hidden_0/MatMul_grad/MatMul=^gradients/main_graph_1/hidden_0/MatMul_grad/tuple/group_deps*
T0*E
_class;
97loc:@gradients/main_graph_1/hidden_0/MatMul_grad/MatMul
?
Fgradients/main_graph_1/hidden_0/MatMul_grad/tuple/control_dependency_1Identity4gradients/main_graph_1/hidden_0/MatMul_grad/MatMul_1=^gradients/main_graph_1/hidden_0/MatMul_grad/tuple/group_deps*
T0*G
_class=
;9loc:@gradients/main_graph_1/hidden_0/MatMul_grad/MatMul_1
?
(gradients/dense/BiasAdd_grad/BiasAddGradBiasAddGrad/gradients/sub_4_grad/tuple/control_dependency_1*
T0*
data_formatNHWC
?
-gradients/dense/BiasAdd_grad/tuple/group_depsNoOp0^gradients/sub_4_grad/tuple/control_dependency_1)^gradients/dense/BiasAdd_grad/BiasAddGrad
?
5gradients/dense/BiasAdd_grad/tuple/control_dependencyIdentity/gradients/sub_4_grad/tuple/control_dependency_1.^gradients/dense/BiasAdd_grad/tuple/group_deps*
T0*1
_class'
%#loc:@gradients/sub_4_grad/Reshape_1
?
7gradients/dense/BiasAdd_grad/tuple/control_dependency_1Identity(gradients/dense/BiasAdd_grad/BiasAddGrad.^gradients/dense/BiasAdd_grad/tuple/group_deps*
T0*;
_class1
/-loc:@gradients/dense/BiasAdd_grad/BiasAddGrad
?
"gradients/dense/MatMul_grad/MatMulMatMul5gradients/dense/BiasAdd_grad/tuple/control_dependencydense/kernel/read*
transpose_b(*
T0*
transpose_a( 
?
$gradients/dense/MatMul_grad/MatMul_1MatMulmain_graph_0/hidden_2/Mul5gradients/dense/BiasAdd_grad/tuple/control_dependency*
transpose_b( *
T0*
transpose_a(
?
,gradients/dense/MatMul_grad/tuple/group_depsNoOp#^gradients/dense/MatMul_grad/MatMul%^gradients/dense/MatMul_grad/MatMul_1
?
4gradients/dense/MatMul_grad/tuple/control_dependencyIdentity"gradients/dense/MatMul_grad/MatMul-^gradients/dense/MatMul_grad/tuple/group_deps*
T0*5
_class+
)'loc:@gradients/dense/MatMul_grad/MatMul
?
6gradients/dense/MatMul_grad/tuple/control_dependency_1Identity$gradients/dense/MatMul_grad/MatMul_1-^gradients/dense/MatMul_grad/tuple/group_deps*
T0*7
_class-
+)loc:@gradients/dense/MatMul_grad/MatMul_1
o
.gradients/main_graph_0/hidden_2/Mul_grad/ShapeShapemain_graph_0/hidden_2/BiasAdd*
T0*
out_type0
q
0gradients/main_graph_0/hidden_2/Mul_grad/Shape_1Shapemain_graph_0/hidden_2/Sigmoid*
T0*
out_type0
?
>gradients/main_graph_0/hidden_2/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs.gradients/main_graph_0/hidden_2/Mul_grad/Shape0gradients/main_graph_0/hidden_2/Mul_grad/Shape_1*
T0
?
,gradients/main_graph_0/hidden_2/Mul_grad/MulMul4gradients/dense/MatMul_grad/tuple/control_dependencymain_graph_0/hidden_2/Sigmoid*
T0
?
,gradients/main_graph_0/hidden_2/Mul_grad/SumSum,gradients/main_graph_0/hidden_2/Mul_grad/Mul>gradients/main_graph_0/hidden_2/Mul_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
?
0gradients/main_graph_0/hidden_2/Mul_grad/ReshapeReshape,gradients/main_graph_0/hidden_2/Mul_grad/Sum.gradients/main_graph_0/hidden_2/Mul_grad/Shape*
T0*
Tshape0
?
.gradients/main_graph_0/hidden_2/Mul_grad/Mul_1Mulmain_graph_0/hidden_2/BiasAdd4gradients/dense/MatMul_grad/tuple/control_dependency*
T0
?
.gradients/main_graph_0/hidden_2/Mul_grad/Sum_1Sum.gradients/main_graph_0/hidden_2/Mul_grad/Mul_1@gradients/main_graph_0/hidden_2/Mul_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
2gradients/main_graph_0/hidden_2/Mul_grad/Reshape_1Reshape.gradients/main_graph_0/hidden_2/Mul_grad/Sum_10gradients/main_graph_0/hidden_2/Mul_grad/Shape_1*
T0*
Tshape0
?
9gradients/main_graph_0/hidden_2/Mul_grad/tuple/group_depsNoOp1^gradients/main_graph_0/hidden_2/Mul_grad/Reshape3^gradients/main_graph_0/hidden_2/Mul_grad/Reshape_1
?
Agradients/main_graph_0/hidden_2/Mul_grad/tuple/control_dependencyIdentity0gradients/main_graph_0/hidden_2/Mul_grad/Reshape:^gradients/main_graph_0/hidden_2/Mul_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/main_graph_0/hidden_2/Mul_grad/Reshape
?
Cgradients/main_graph_0/hidden_2/Mul_grad/tuple/control_dependency_1Identity2gradients/main_graph_0/hidden_2/Mul_grad/Reshape_1:^gradients/main_graph_0/hidden_2/Mul_grad/tuple/group_deps*
T0*E
_class;
97loc:@gradients/main_graph_0/hidden_2/Mul_grad/Reshape_1
?
8gradients/main_graph_0/hidden_2/Sigmoid_grad/SigmoidGradSigmoidGradmain_graph_0/hidden_2/SigmoidCgradients/main_graph_0/hidden_2/Mul_grad/tuple/control_dependency_1*
T0
?
gradients/AddN_6AddNAgradients/main_graph_0/hidden_2/Mul_grad/tuple/control_dependency8gradients/main_graph_0/hidden_2/Sigmoid_grad/SigmoidGrad*
T0*
N*C
_class9
75loc:@gradients/main_graph_0/hidden_2/Mul_grad/Reshape
y
8gradients/main_graph_0/hidden_2/BiasAdd_grad/BiasAddGradBiasAddGradgradients/AddN_6*
T0*
data_formatNHWC
?
=gradients/main_graph_0/hidden_2/BiasAdd_grad/tuple/group_depsNoOp^gradients/AddN_69^gradients/main_graph_0/hidden_2/BiasAdd_grad/BiasAddGrad
?
Egradients/main_graph_0/hidden_2/BiasAdd_grad/tuple/control_dependencyIdentitygradients/AddN_6>^gradients/main_graph_0/hidden_2/BiasAdd_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/main_graph_0/hidden_2/Mul_grad/Reshape
?
Ggradients/main_graph_0/hidden_2/BiasAdd_grad/tuple/control_dependency_1Identity8gradients/main_graph_0/hidden_2/BiasAdd_grad/BiasAddGrad>^gradients/main_graph_0/hidden_2/BiasAdd_grad/tuple/group_deps*
T0*K
_classA
?=loc:@gradients/main_graph_0/hidden_2/BiasAdd_grad/BiasAddGrad
?
2gradients/main_graph_0/hidden_2/MatMul_grad/MatMulMatMulEgradients/main_graph_0/hidden_2/BiasAdd_grad/tuple/control_dependency!main_graph_0/hidden_2/kernel/read*
transpose_b(*
T0*
transpose_a( 
?
4gradients/main_graph_0/hidden_2/MatMul_grad/MatMul_1MatMulmain_graph_0/hidden_1/MulEgradients/main_graph_0/hidden_2/BiasAdd_grad/tuple/control_dependency*
transpose_b( *
T0*
transpose_a(
?
<gradients/main_graph_0/hidden_2/MatMul_grad/tuple/group_depsNoOp3^gradients/main_graph_0/hidden_2/MatMul_grad/MatMul5^gradients/main_graph_0/hidden_2/MatMul_grad/MatMul_1
?
Dgradients/main_graph_0/hidden_2/MatMul_grad/tuple/control_dependencyIdentity2gradients/main_graph_0/hidden_2/MatMul_grad/MatMul=^gradients/main_graph_0/hidden_2/MatMul_grad/tuple/group_deps*
T0*E
_class;
97loc:@gradients/main_graph_0/hidden_2/MatMul_grad/MatMul
?
Fgradients/main_graph_0/hidden_2/MatMul_grad/tuple/control_dependency_1Identity4gradients/main_graph_0/hidden_2/MatMul_grad/MatMul_1=^gradients/main_graph_0/hidden_2/MatMul_grad/tuple/group_deps*
T0*G
_class=
;9loc:@gradients/main_graph_0/hidden_2/MatMul_grad/MatMul_1
o
.gradients/main_graph_0/hidden_1/Mul_grad/ShapeShapemain_graph_0/hidden_1/BiasAdd*
T0*
out_type0
q
0gradients/main_graph_0/hidden_1/Mul_grad/Shape_1Shapemain_graph_0/hidden_1/Sigmoid*
T0*
out_type0
?
>gradients/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs.gradients/main_graph_0/hidden_1/Mul_grad/Shape0gradients/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0
?
,gradients/main_graph_0/hidden_1/Mul_grad/MulMulDgradients/main_graph_0/hidden_2/MatMul_grad/tuple/control_dependencymain_graph_0/hidden_1/Sigmoid*
T0
?
,gradients/main_graph_0/hidden_1/Mul_grad/SumSum,gradients/main_graph_0/hidden_1/Mul_grad/Mul>gradients/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
?
0gradients/main_graph_0/hidden_1/Mul_grad/ReshapeReshape,gradients/main_graph_0/hidden_1/Mul_grad/Sum.gradients/main_graph_0/hidden_1/Mul_grad/Shape*
T0*
Tshape0
?
.gradients/main_graph_0/hidden_1/Mul_grad/Mul_1Mulmain_graph_0/hidden_1/BiasAddDgradients/main_graph_0/hidden_2/MatMul_grad/tuple/control_dependency*
T0
?
.gradients/main_graph_0/hidden_1/Mul_grad/Sum_1Sum.gradients/main_graph_0/hidden_1/Mul_grad/Mul_1@gradients/main_graph_0/hidden_1/Mul_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
2gradients/main_graph_0/hidden_1/Mul_grad/Reshape_1Reshape.gradients/main_graph_0/hidden_1/Mul_grad/Sum_10gradients/main_graph_0/hidden_1/Mul_grad/Shape_1*
T0*
Tshape0
?
9gradients/main_graph_0/hidden_1/Mul_grad/tuple/group_depsNoOp1^gradients/main_graph_0/hidden_1/Mul_grad/Reshape3^gradients/main_graph_0/hidden_1/Mul_grad/Reshape_1
?
Agradients/main_graph_0/hidden_1/Mul_grad/tuple/control_dependencyIdentity0gradients/main_graph_0/hidden_1/Mul_grad/Reshape:^gradients/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/main_graph_0/hidden_1/Mul_grad/Reshape
?
Cgradients/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1Identity2gradients/main_graph_0/hidden_1/Mul_grad/Reshape_1:^gradients/main_graph_0/hidden_1/Mul_grad/tuple/group_deps*
T0*E
_class;
97loc:@gradients/main_graph_0/hidden_1/Mul_grad/Reshape_1
?
8gradients/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGradSigmoidGradmain_graph_0/hidden_1/SigmoidCgradients/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency_1*
T0
?
gradients/AddN_7AddNAgradients/main_graph_0/hidden_1/Mul_grad/tuple/control_dependency8gradients/main_graph_0/hidden_1/Sigmoid_grad/SigmoidGrad*
T0*
N*C
_class9
75loc:@gradients/main_graph_0/hidden_1/Mul_grad/Reshape
y
8gradients/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGradBiasAddGradgradients/AddN_7*
T0*
data_formatNHWC
?
=gradients/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_depsNoOp^gradients/AddN_79^gradients/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
?
Egradients/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependencyIdentitygradients/AddN_7>^gradients/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/main_graph_0/hidden_1/Mul_grad/Reshape
?
Ggradients/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1Identity8gradients/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad>^gradients/main_graph_0/hidden_1/BiasAdd_grad/tuple/group_deps*
T0*K
_classA
?=loc:@gradients/main_graph_0/hidden_1/BiasAdd_grad/BiasAddGrad
?
2gradients/main_graph_0/hidden_1/MatMul_grad/MatMulMatMulEgradients/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency!main_graph_0/hidden_1/kernel/read*
transpose_b(*
T0*
transpose_a( 
?
4gradients/main_graph_0/hidden_1/MatMul_grad/MatMul_1MatMulmain_graph_0/hidden_0/MulEgradients/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency*
transpose_b( *
T0*
transpose_a(
?
<gradients/main_graph_0/hidden_1/MatMul_grad/tuple/group_depsNoOp3^gradients/main_graph_0/hidden_1/MatMul_grad/MatMul5^gradients/main_graph_0/hidden_1/MatMul_grad/MatMul_1
?
Dgradients/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependencyIdentity2gradients/main_graph_0/hidden_1/MatMul_grad/MatMul=^gradients/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*E
_class;
97loc:@gradients/main_graph_0/hidden_1/MatMul_grad/MatMul
?
Fgradients/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1Identity4gradients/main_graph_0/hidden_1/MatMul_grad/MatMul_1=^gradients/main_graph_0/hidden_1/MatMul_grad/tuple/group_deps*
T0*G
_class=
;9loc:@gradients/main_graph_0/hidden_1/MatMul_grad/MatMul_1
o
.gradients/main_graph_0/hidden_0/Mul_grad/ShapeShapemain_graph_0/hidden_0/BiasAdd*
T0*
out_type0
q
0gradients/main_graph_0/hidden_0/Mul_grad/Shape_1Shapemain_graph_0/hidden_0/Sigmoid*
T0*
out_type0
?
>gradients/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgsBroadcastGradientArgs.gradients/main_graph_0/hidden_0/Mul_grad/Shape0gradients/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0
?
,gradients/main_graph_0/hidden_0/Mul_grad/MulMulDgradients/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependencymain_graph_0/hidden_0/Sigmoid*
T0
?
,gradients/main_graph_0/hidden_0/Mul_grad/SumSum,gradients/main_graph_0/hidden_0/Mul_grad/Mul>gradients/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs*
	keep_dims( *
T0*

Tidx0
?
0gradients/main_graph_0/hidden_0/Mul_grad/ReshapeReshape,gradients/main_graph_0/hidden_0/Mul_grad/Sum.gradients/main_graph_0/hidden_0/Mul_grad/Shape*
T0*
Tshape0
?
.gradients/main_graph_0/hidden_0/Mul_grad/Mul_1Mulmain_graph_0/hidden_0/BiasAddDgradients/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency*
T0
?
.gradients/main_graph_0/hidden_0/Mul_grad/Sum_1Sum.gradients/main_graph_0/hidden_0/Mul_grad/Mul_1@gradients/main_graph_0/hidden_0/Mul_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*

Tidx0
?
2gradients/main_graph_0/hidden_0/Mul_grad/Reshape_1Reshape.gradients/main_graph_0/hidden_0/Mul_grad/Sum_10gradients/main_graph_0/hidden_0/Mul_grad/Shape_1*
T0*
Tshape0
?
9gradients/main_graph_0/hidden_0/Mul_grad/tuple/group_depsNoOp1^gradients/main_graph_0/hidden_0/Mul_grad/Reshape3^gradients/main_graph_0/hidden_0/Mul_grad/Reshape_1
?
Agradients/main_graph_0/hidden_0/Mul_grad/tuple/control_dependencyIdentity0gradients/main_graph_0/hidden_0/Mul_grad/Reshape:^gradients/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/main_graph_0/hidden_0/Mul_grad/Reshape
?
Cgradients/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1Identity2gradients/main_graph_0/hidden_0/Mul_grad/Reshape_1:^gradients/main_graph_0/hidden_0/Mul_grad/tuple/group_deps*
T0*E
_class;
97loc:@gradients/main_graph_0/hidden_0/Mul_grad/Reshape_1
?
8gradients/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGradSigmoidGradmain_graph_0/hidden_0/SigmoidCgradients/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency_1*
T0
?
gradients/AddN_8AddNAgradients/main_graph_0/hidden_0/Mul_grad/tuple/control_dependency8gradients/main_graph_0/hidden_0/Sigmoid_grad/SigmoidGrad*
T0*
N*C
_class9
75loc:@gradients/main_graph_0/hidden_0/Mul_grad/Reshape
y
8gradients/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGradBiasAddGradgradients/AddN_8*
T0*
data_formatNHWC
?
=gradients/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_depsNoOp^gradients/AddN_89^gradients/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
?
Egradients/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependencyIdentitygradients/AddN_8>^gradients/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*C
_class9
75loc:@gradients/main_graph_0/hidden_0/Mul_grad/Reshape
?
Ggradients/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1Identity8gradients/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad>^gradients/main_graph_0/hidden_0/BiasAdd_grad/tuple/group_deps*
T0*K
_classA
?=loc:@gradients/main_graph_0/hidden_0/BiasAdd_grad/BiasAddGrad
?
2gradients/main_graph_0/hidden_0/MatMul_grad/MatMulMatMulEgradients/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency!main_graph_0/hidden_0/kernel/read*
transpose_b(*
T0*
transpose_a( 
?
4gradients/main_graph_0/hidden_0/MatMul_grad/MatMul_1MatMulnormalized_stateEgradients/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency*
transpose_b( *
T0*
transpose_a(
?
<gradients/main_graph_0/hidden_0/MatMul_grad/tuple/group_depsNoOp3^gradients/main_graph_0/hidden_0/MatMul_grad/MatMul5^gradients/main_graph_0/hidden_0/MatMul_grad/MatMul_1
?
Dgradients/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependencyIdentity2gradients/main_graph_0/hidden_0/MatMul_grad/MatMul=^gradients/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*E
_class;
97loc:@gradients/main_graph_0/hidden_0/MatMul_grad/MatMul
?
Fgradients/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1Identity4gradients/main_graph_0/hidden_0/MatMul_grad/MatMul_1=^gradients/main_graph_0/hidden_0/MatMul_grad/tuple/group_deps*
T0*G
_class=
;9loc:@gradients/main_graph_0/hidden_0/MatMul_grad/MatMul_1
e
beta1_power/initial_valueConst*
valueB
 *fff?*
dtype0*
_class
loc:@dense/bias
v
beta1_power
VariableV2*
dtype0*
shared_name *
shape: *
	container *
_class
loc:@dense/bias
?
beta1_power/AssignAssignbeta1_powerbeta1_power/initial_value*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/bias
Q
beta1_power/readIdentitybeta1_power*
T0*
_class
loc:@dense/bias
e
beta2_power/initial_valueConst*
valueB
 *w??*
dtype0*
_class
loc:@dense/bias
v
beta2_power
VariableV2*
dtype0*
shared_name *
shape: *
	container *
_class
loc:@dense/bias
?
beta2_power/AssignAssignbeta2_powerbeta2_power/initial_value*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/bias
Q
beta2_power/readIdentitybeta2_power*
T0*
_class
loc:@dense/bias
?
Cmain_graph_0/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensorConst*
valueB"1   5   *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
9main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
3main_graph_0/hidden_0/kernel/Adam/Initializer/zerosFillCmain_graph_0/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensor9main_graph_0/hidden_0/kernel/Adam/Initializer/zeros/Const*
T0*

index_type0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
!main_graph_0/hidden_0/kernel/Adam
VariableV2*
dtype0*
shared_name *
shape
:15*
	container */
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
(main_graph_0/hidden_0/kernel/Adam/AssignAssign!main_graph_0/hidden_0/kernel/Adam3main_graph_0/hidden_0/kernel/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
&main_graph_0/hidden_0/kernel/Adam/readIdentity!main_graph_0/hidden_0/kernel/Adam*
T0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
Emain_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB"1   5   *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
;main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
5main_graph_0/hidden_0/kernel/Adam_1/Initializer/zerosFillEmain_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensor;main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros/Const*
T0*

index_type0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
#main_graph_0/hidden_0/kernel/Adam_1
VariableV2*
dtype0*
shared_name *
shape
:15*
	container */
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
*main_graph_0/hidden_0/kernel/Adam_1/AssignAssign#main_graph_0/hidden_0/kernel/Adam_15main_graph_0/hidden_0/kernel/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
(main_graph_0/hidden_0/kernel/Adam_1/readIdentity#main_graph_0/hidden_0/kernel/Adam_1*
T0*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
Amain_graph_0/hidden_0/bias/Adam/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
7main_graph_0/hidden_0/bias/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
1main_graph_0/hidden_0/bias/Adam/Initializer/zerosFillAmain_graph_0/hidden_0/bias/Adam/Initializer/zeros/shape_as_tensor7main_graph_0/hidden_0/bias/Adam/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
main_graph_0/hidden_0/bias/Adam
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_0/hidden_0/bias
?
&main_graph_0/hidden_0/bias/Adam/AssignAssignmain_graph_0/hidden_0/bias/Adam1main_graph_0/hidden_0/bias/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
$main_graph_0/hidden_0/bias/Adam/readIdentitymain_graph_0/hidden_0/bias/Adam*
T0*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
Cmain_graph_0/hidden_0/bias/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
9main_graph_0/hidden_0/bias/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
3main_graph_0/hidden_0/bias/Adam_1/Initializer/zerosFillCmain_graph_0/hidden_0/bias/Adam_1/Initializer/zeros/shape_as_tensor9main_graph_0/hidden_0/bias/Adam_1/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
!main_graph_0/hidden_0/bias/Adam_1
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_0/hidden_0/bias
?
(main_graph_0/hidden_0/bias/Adam_1/AssignAssign!main_graph_0/hidden_0/bias/Adam_13main_graph_0/hidden_0/bias/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
&main_graph_0/hidden_0/bias/Adam_1/readIdentity!main_graph_0/hidden_0/bias/Adam_1*
T0*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
Cmain_graph_0/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensorConst*
valueB"5   5   *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
9main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
3main_graph_0/hidden_1/kernel/Adam/Initializer/zerosFillCmain_graph_0/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensor9main_graph_0/hidden_1/kernel/Adam/Initializer/zeros/Const*
T0*

index_type0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
!main_graph_0/hidden_1/kernel/Adam
VariableV2*
dtype0*
shared_name *
shape
:55*
	container */
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
(main_graph_0/hidden_1/kernel/Adam/AssignAssign!main_graph_0/hidden_1/kernel/Adam3main_graph_0/hidden_1/kernel/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
&main_graph_0/hidden_1/kernel/Adam/readIdentity!main_graph_0/hidden_1/kernel/Adam*
T0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
Emain_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB"5   5   *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
;main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
5main_graph_0/hidden_1/kernel/Adam_1/Initializer/zerosFillEmain_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensor;main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros/Const*
T0*

index_type0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
#main_graph_0/hidden_1/kernel/Adam_1
VariableV2*
dtype0*
shared_name *
shape
:55*
	container */
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
*main_graph_0/hidden_1/kernel/Adam_1/AssignAssign#main_graph_0/hidden_1/kernel/Adam_15main_graph_0/hidden_1/kernel/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
(main_graph_0/hidden_1/kernel/Adam_1/readIdentity#main_graph_0/hidden_1/kernel/Adam_1*
T0*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
Amain_graph_0/hidden_1/bias/Adam/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
7main_graph_0/hidden_1/bias/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
1main_graph_0/hidden_1/bias/Adam/Initializer/zerosFillAmain_graph_0/hidden_1/bias/Adam/Initializer/zeros/shape_as_tensor7main_graph_0/hidden_1/bias/Adam/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
main_graph_0/hidden_1/bias/Adam
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_0/hidden_1/bias
?
&main_graph_0/hidden_1/bias/Adam/AssignAssignmain_graph_0/hidden_1/bias/Adam1main_graph_0/hidden_1/bias/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
$main_graph_0/hidden_1/bias/Adam/readIdentitymain_graph_0/hidden_1/bias/Adam*
T0*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
Cmain_graph_0/hidden_1/bias/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
9main_graph_0/hidden_1/bias/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
3main_graph_0/hidden_1/bias/Adam_1/Initializer/zerosFillCmain_graph_0/hidden_1/bias/Adam_1/Initializer/zeros/shape_as_tensor9main_graph_0/hidden_1/bias/Adam_1/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
!main_graph_0/hidden_1/bias/Adam_1
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_0/hidden_1/bias
?
(main_graph_0/hidden_1/bias/Adam_1/AssignAssign!main_graph_0/hidden_1/bias/Adam_13main_graph_0/hidden_1/bias/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
&main_graph_0/hidden_1/bias/Adam_1/readIdentity!main_graph_0/hidden_1/bias/Adam_1*
T0*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
Cmain_graph_0/hidden_2/kernel/Adam/Initializer/zeros/shape_as_tensorConst*
valueB"5   5   *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
9main_graph_0/hidden_2/kernel/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
3main_graph_0/hidden_2/kernel/Adam/Initializer/zerosFillCmain_graph_0/hidden_2/kernel/Adam/Initializer/zeros/shape_as_tensor9main_graph_0/hidden_2/kernel/Adam/Initializer/zeros/Const*
T0*

index_type0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
!main_graph_0/hidden_2/kernel/Adam
VariableV2*
dtype0*
shared_name *
shape
:55*
	container */
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
(main_graph_0/hidden_2/kernel/Adam/AssignAssign!main_graph_0/hidden_2/kernel/Adam3main_graph_0/hidden_2/kernel/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
&main_graph_0/hidden_2/kernel/Adam/readIdentity!main_graph_0/hidden_2/kernel/Adam*
T0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
Emain_graph_0/hidden_2/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB"5   5   *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
;main_graph_0/hidden_2/kernel/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
5main_graph_0/hidden_2/kernel/Adam_1/Initializer/zerosFillEmain_graph_0/hidden_2/kernel/Adam_1/Initializer/zeros/shape_as_tensor;main_graph_0/hidden_2/kernel/Adam_1/Initializer/zeros/Const*
T0*

index_type0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
#main_graph_0/hidden_2/kernel/Adam_1
VariableV2*
dtype0*
shared_name *
shape
:55*
	container */
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
*main_graph_0/hidden_2/kernel/Adam_1/AssignAssign#main_graph_0/hidden_2/kernel/Adam_15main_graph_0/hidden_2/kernel/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
(main_graph_0/hidden_2/kernel/Adam_1/readIdentity#main_graph_0/hidden_2/kernel/Adam_1*
T0*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
Amain_graph_0/hidden_2/bias/Adam/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
7main_graph_0/hidden_2/bias/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
1main_graph_0/hidden_2/bias/Adam/Initializer/zerosFillAmain_graph_0/hidden_2/bias/Adam/Initializer/zeros/shape_as_tensor7main_graph_0/hidden_2/bias/Adam/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
main_graph_0/hidden_2/bias/Adam
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_0/hidden_2/bias
?
&main_graph_0/hidden_2/bias/Adam/AssignAssignmain_graph_0/hidden_2/bias/Adam1main_graph_0/hidden_2/bias/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
$main_graph_0/hidden_2/bias/Adam/readIdentitymain_graph_0/hidden_2/bias/Adam*
T0*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
Cmain_graph_0/hidden_2/bias/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
9main_graph_0/hidden_2/bias/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
3main_graph_0/hidden_2/bias/Adam_1/Initializer/zerosFillCmain_graph_0/hidden_2/bias/Adam_1/Initializer/zeros/shape_as_tensor9main_graph_0/hidden_2/bias/Adam_1/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
!main_graph_0/hidden_2/bias/Adam_1
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_0/hidden_2/bias
?
(main_graph_0/hidden_2/bias/Adam_1/AssignAssign!main_graph_0/hidden_2/bias/Adam_13main_graph_0/hidden_2/bias/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
&main_graph_0/hidden_2/bias/Adam_1/readIdentity!main_graph_0/hidden_2/bias/Adam_1*
T0*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
Cmain_graph_1/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensorConst*
valueB"1   5   *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
9main_graph_1/hidden_0/kernel/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
3main_graph_1/hidden_0/kernel/Adam/Initializer/zerosFillCmain_graph_1/hidden_0/kernel/Adam/Initializer/zeros/shape_as_tensor9main_graph_1/hidden_0/kernel/Adam/Initializer/zeros/Const*
T0*

index_type0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
!main_graph_1/hidden_0/kernel/Adam
VariableV2*
dtype0*
shared_name *
shape
:15*
	container */
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
(main_graph_1/hidden_0/kernel/Adam/AssignAssign!main_graph_1/hidden_0/kernel/Adam3main_graph_1/hidden_0/kernel/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
&main_graph_1/hidden_0/kernel/Adam/readIdentity!main_graph_1/hidden_0/kernel/Adam*
T0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
Emain_graph_1/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB"1   5   *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
;main_graph_1/hidden_0/kernel/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
5main_graph_1/hidden_0/kernel/Adam_1/Initializer/zerosFillEmain_graph_1/hidden_0/kernel/Adam_1/Initializer/zeros/shape_as_tensor;main_graph_1/hidden_0/kernel/Adam_1/Initializer/zeros/Const*
T0*

index_type0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
#main_graph_1/hidden_0/kernel/Adam_1
VariableV2*
dtype0*
shared_name *
shape
:15*
	container */
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
*main_graph_1/hidden_0/kernel/Adam_1/AssignAssign#main_graph_1/hidden_0/kernel/Adam_15main_graph_1/hidden_0/kernel/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
(main_graph_1/hidden_0/kernel/Adam_1/readIdentity#main_graph_1/hidden_0/kernel/Adam_1*
T0*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
Amain_graph_1/hidden_0/bias/Adam/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
7main_graph_1/hidden_0/bias/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
1main_graph_1/hidden_0/bias/Adam/Initializer/zerosFillAmain_graph_1/hidden_0/bias/Adam/Initializer/zeros/shape_as_tensor7main_graph_1/hidden_0/bias/Adam/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
main_graph_1/hidden_0/bias/Adam
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_1/hidden_0/bias
?
&main_graph_1/hidden_0/bias/Adam/AssignAssignmain_graph_1/hidden_0/bias/Adam1main_graph_1/hidden_0/bias/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
$main_graph_1/hidden_0/bias/Adam/readIdentitymain_graph_1/hidden_0/bias/Adam*
T0*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
Cmain_graph_1/hidden_0/bias/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
9main_graph_1/hidden_0/bias/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
3main_graph_1/hidden_0/bias/Adam_1/Initializer/zerosFillCmain_graph_1/hidden_0/bias/Adam_1/Initializer/zeros/shape_as_tensor9main_graph_1/hidden_0/bias/Adam_1/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
!main_graph_1/hidden_0/bias/Adam_1
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_1/hidden_0/bias
?
(main_graph_1/hidden_0/bias/Adam_1/AssignAssign!main_graph_1/hidden_0/bias/Adam_13main_graph_1/hidden_0/bias/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
&main_graph_1/hidden_0/bias/Adam_1/readIdentity!main_graph_1/hidden_0/bias/Adam_1*
T0*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
Cmain_graph_1/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensorConst*
valueB"5   5   *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
9main_graph_1/hidden_1/kernel/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
3main_graph_1/hidden_1/kernel/Adam/Initializer/zerosFillCmain_graph_1/hidden_1/kernel/Adam/Initializer/zeros/shape_as_tensor9main_graph_1/hidden_1/kernel/Adam/Initializer/zeros/Const*
T0*

index_type0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
!main_graph_1/hidden_1/kernel/Adam
VariableV2*
dtype0*
shared_name *
shape
:55*
	container */
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
(main_graph_1/hidden_1/kernel/Adam/AssignAssign!main_graph_1/hidden_1/kernel/Adam3main_graph_1/hidden_1/kernel/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
&main_graph_1/hidden_1/kernel/Adam/readIdentity!main_graph_1/hidden_1/kernel/Adam*
T0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
Emain_graph_1/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB"5   5   *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
;main_graph_1/hidden_1/kernel/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
5main_graph_1/hidden_1/kernel/Adam_1/Initializer/zerosFillEmain_graph_1/hidden_1/kernel/Adam_1/Initializer/zeros/shape_as_tensor;main_graph_1/hidden_1/kernel/Adam_1/Initializer/zeros/Const*
T0*

index_type0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
#main_graph_1/hidden_1/kernel/Adam_1
VariableV2*
dtype0*
shared_name *
shape
:55*
	container */
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
*main_graph_1/hidden_1/kernel/Adam_1/AssignAssign#main_graph_1/hidden_1/kernel/Adam_15main_graph_1/hidden_1/kernel/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
(main_graph_1/hidden_1/kernel/Adam_1/readIdentity#main_graph_1/hidden_1/kernel/Adam_1*
T0*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
Amain_graph_1/hidden_1/bias/Adam/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
7main_graph_1/hidden_1/bias/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
1main_graph_1/hidden_1/bias/Adam/Initializer/zerosFillAmain_graph_1/hidden_1/bias/Adam/Initializer/zeros/shape_as_tensor7main_graph_1/hidden_1/bias/Adam/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
main_graph_1/hidden_1/bias/Adam
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_1/hidden_1/bias
?
&main_graph_1/hidden_1/bias/Adam/AssignAssignmain_graph_1/hidden_1/bias/Adam1main_graph_1/hidden_1/bias/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
$main_graph_1/hidden_1/bias/Adam/readIdentitymain_graph_1/hidden_1/bias/Adam*
T0*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
Cmain_graph_1/hidden_1/bias/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
9main_graph_1/hidden_1/bias/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
3main_graph_1/hidden_1/bias/Adam_1/Initializer/zerosFillCmain_graph_1/hidden_1/bias/Adam_1/Initializer/zeros/shape_as_tensor9main_graph_1/hidden_1/bias/Adam_1/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
!main_graph_1/hidden_1/bias/Adam_1
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_1/hidden_1/bias
?
(main_graph_1/hidden_1/bias/Adam_1/AssignAssign!main_graph_1/hidden_1/bias/Adam_13main_graph_1/hidden_1/bias/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
&main_graph_1/hidden_1/bias/Adam_1/readIdentity!main_graph_1/hidden_1/bias/Adam_1*
T0*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
Cmain_graph_1/hidden_2/kernel/Adam/Initializer/zeros/shape_as_tensorConst*
valueB"5   5   *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
9main_graph_1/hidden_2/kernel/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
3main_graph_1/hidden_2/kernel/Adam/Initializer/zerosFillCmain_graph_1/hidden_2/kernel/Adam/Initializer/zeros/shape_as_tensor9main_graph_1/hidden_2/kernel/Adam/Initializer/zeros/Const*
T0*

index_type0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
!main_graph_1/hidden_2/kernel/Adam
VariableV2*
dtype0*
shared_name *
shape
:55*
	container */
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
(main_graph_1/hidden_2/kernel/Adam/AssignAssign!main_graph_1/hidden_2/kernel/Adam3main_graph_1/hidden_2/kernel/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
&main_graph_1/hidden_2/kernel/Adam/readIdentity!main_graph_1/hidden_2/kernel/Adam*
T0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
Emain_graph_1/hidden_2/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB"5   5   *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
;main_graph_1/hidden_2/kernel/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
5main_graph_1/hidden_2/kernel/Adam_1/Initializer/zerosFillEmain_graph_1/hidden_2/kernel/Adam_1/Initializer/zeros/shape_as_tensor;main_graph_1/hidden_2/kernel/Adam_1/Initializer/zeros/Const*
T0*

index_type0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
#main_graph_1/hidden_2/kernel/Adam_1
VariableV2*
dtype0*
shared_name *
shape
:55*
	container */
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
*main_graph_1/hidden_2/kernel/Adam_1/AssignAssign#main_graph_1/hidden_2/kernel/Adam_15main_graph_1/hidden_2/kernel/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
(main_graph_1/hidden_2/kernel/Adam_1/readIdentity#main_graph_1/hidden_2/kernel/Adam_1*
T0*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
Amain_graph_1/hidden_2/bias/Adam/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
7main_graph_1/hidden_2/bias/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
1main_graph_1/hidden_2/bias/Adam/Initializer/zerosFillAmain_graph_1/hidden_2/bias/Adam/Initializer/zeros/shape_as_tensor7main_graph_1/hidden_2/bias/Adam/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
main_graph_1/hidden_2/bias/Adam
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_1/hidden_2/bias
?
&main_graph_1/hidden_2/bias/Adam/AssignAssignmain_graph_1/hidden_2/bias/Adam1main_graph_1/hidden_2/bias/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
$main_graph_1/hidden_2/bias/Adam/readIdentitymain_graph_1/hidden_2/bias/Adam*
T0*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
Cmain_graph_1/hidden_2/bias/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB:5*
dtype0*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
9main_graph_1/hidden_2/bias/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
3main_graph_1/hidden_2/bias/Adam_1/Initializer/zerosFillCmain_graph_1/hidden_2/bias/Adam_1/Initializer/zeros/shape_as_tensor9main_graph_1/hidden_2/bias/Adam_1/Initializer/zeros/Const*
T0*

index_type0*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
!main_graph_1/hidden_2/bias/Adam_1
VariableV2*
dtype0*
shared_name *
shape:5*
	container *-
_class#
!loc:@main_graph_1/hidden_2/bias
?
(main_graph_1/hidden_2/bias/Adam_1/AssignAssign!main_graph_1/hidden_2/bias/Adam_13main_graph_1/hidden_2/bias/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
&main_graph_1/hidden_2/bias/Adam_1/readIdentity!main_graph_1/hidden_2/bias/Adam_1*
T0*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
3dense/kernel/Adam/Initializer/zeros/shape_as_tensorConst*
valueB"5      *
dtype0*
_class
loc:@dense/kernel
w
)dense/kernel/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*
_class
loc:@dense/kernel
?
#dense/kernel/Adam/Initializer/zerosFill3dense/kernel/Adam/Initializer/zeros/shape_as_tensor)dense/kernel/Adam/Initializer/zeros/Const*
T0*

index_type0*
_class
loc:@dense/kernel
?
dense/kernel/Adam
VariableV2*
dtype0*
shared_name *
shape
:5*
	container *
_class
loc:@dense/kernel
?
dense/kernel/Adam/AssignAssigndense/kernel/Adam#dense/kernel/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/kernel
_
dense/kernel/Adam/readIdentitydense/kernel/Adam*
T0*
_class
loc:@dense/kernel
?
5dense/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB"5      *
dtype0*
_class
loc:@dense/kernel
y
+dense/kernel/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*
_class
loc:@dense/kernel
?
%dense/kernel/Adam_1/Initializer/zerosFill5dense/kernel/Adam_1/Initializer/zeros/shape_as_tensor+dense/kernel/Adam_1/Initializer/zeros/Const*
T0*

index_type0*
_class
loc:@dense/kernel
?
dense/kernel/Adam_1
VariableV2*
dtype0*
shared_name *
shape
:5*
	container *
_class
loc:@dense/kernel
?
dense/kernel/Adam_1/AssignAssigndense/kernel/Adam_1%dense/kernel/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/kernel
c
dense/kernel/Adam_1/readIdentitydense/kernel/Adam_1*
T0*
_class
loc:@dense/kernel
~
1dense/bias/Adam/Initializer/zeros/shape_as_tensorConst*
valueB:*
dtype0*
_class
loc:@dense/bias
s
'dense/bias/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*
_class
loc:@dense/bias
?
!dense/bias/Adam/Initializer/zerosFill1dense/bias/Adam/Initializer/zeros/shape_as_tensor'dense/bias/Adam/Initializer/zeros/Const*
T0*

index_type0*
_class
loc:@dense/bias
~
dense/bias/Adam
VariableV2*
dtype0*
shared_name *
shape:*
	container *
_class
loc:@dense/bias
?
dense/bias/Adam/AssignAssigndense/bias/Adam!dense/bias/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/bias
Y
dense/bias/Adam/readIdentitydense/bias/Adam*
T0*
_class
loc:@dense/bias
?
3dense/bias/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB:*
dtype0*
_class
loc:@dense/bias
u
)dense/bias/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*
_class
loc:@dense/bias
?
#dense/bias/Adam_1/Initializer/zerosFill3dense/bias/Adam_1/Initializer/zeros/shape_as_tensor)dense/bias/Adam_1/Initializer/zeros/Const*
T0*

index_type0*
_class
loc:@dense/bias
?
dense/bias/Adam_1
VariableV2*
dtype0*
shared_name *
shape:*
	container *
_class
loc:@dense/bias
?
dense/bias/Adam_1/AssignAssigndense/bias/Adam_1#dense/bias/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/bias
]
dense/bias/Adam_1/readIdentitydense/bias/Adam_1*
T0*
_class
loc:@dense/bias
?
8log_sigma_squared/Adam/Initializer/zeros/shape_as_tensorConst*
valueB:*
dtype0*$
_class
loc:@log_sigma_squared
?
.log_sigma_squared/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*$
_class
loc:@log_sigma_squared
?
(log_sigma_squared/Adam/Initializer/zerosFill8log_sigma_squared/Adam/Initializer/zeros/shape_as_tensor.log_sigma_squared/Adam/Initializer/zeros/Const*
T0*

index_type0*$
_class
loc:@log_sigma_squared
?
log_sigma_squared/Adam
VariableV2*
dtype0*
shared_name *
shape:*
	container *$
_class
loc:@log_sigma_squared
?
log_sigma_squared/Adam/AssignAssignlog_sigma_squared/Adam(log_sigma_squared/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*$
_class
loc:@log_sigma_squared
n
log_sigma_squared/Adam/readIdentitylog_sigma_squared/Adam*
T0*$
_class
loc:@log_sigma_squared
?
:log_sigma_squared/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB:*
dtype0*$
_class
loc:@log_sigma_squared
?
0log_sigma_squared/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*$
_class
loc:@log_sigma_squared
?
*log_sigma_squared/Adam_1/Initializer/zerosFill:log_sigma_squared/Adam_1/Initializer/zeros/shape_as_tensor0log_sigma_squared/Adam_1/Initializer/zeros/Const*
T0*

index_type0*$
_class
loc:@log_sigma_squared
?
log_sigma_squared/Adam_1
VariableV2*
dtype0*
shared_name *
shape:*
	container *$
_class
loc:@log_sigma_squared
?
log_sigma_squared/Adam_1/AssignAssignlog_sigma_squared/Adam_1*log_sigma_squared/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*$
_class
loc:@log_sigma_squared
r
log_sigma_squared/Adam_1/readIdentitylog_sigma_squared/Adam_1*
T0*$
_class
loc:@log_sigma_squared
?
5dense_1/kernel/Adam/Initializer/zeros/shape_as_tensorConst*
valueB"5      *
dtype0*!
_class
loc:@dense_1/kernel
{
+dense_1/kernel/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*!
_class
loc:@dense_1/kernel
?
%dense_1/kernel/Adam/Initializer/zerosFill5dense_1/kernel/Adam/Initializer/zeros/shape_as_tensor+dense_1/kernel/Adam/Initializer/zeros/Const*
T0*

index_type0*!
_class
loc:@dense_1/kernel
?
dense_1/kernel/Adam
VariableV2*
dtype0*
shared_name *
shape
:5*
	container *!
_class
loc:@dense_1/kernel
?
dense_1/kernel/Adam/AssignAssigndense_1/kernel/Adam%dense_1/kernel/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*!
_class
loc:@dense_1/kernel
e
dense_1/kernel/Adam/readIdentitydense_1/kernel/Adam*
T0*!
_class
loc:@dense_1/kernel
?
7dense_1/kernel/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB"5      *
dtype0*!
_class
loc:@dense_1/kernel
}
-dense_1/kernel/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*!
_class
loc:@dense_1/kernel
?
'dense_1/kernel/Adam_1/Initializer/zerosFill7dense_1/kernel/Adam_1/Initializer/zeros/shape_as_tensor-dense_1/kernel/Adam_1/Initializer/zeros/Const*
T0*

index_type0*!
_class
loc:@dense_1/kernel
?
dense_1/kernel/Adam_1
VariableV2*
dtype0*
shared_name *
shape
:5*
	container *!
_class
loc:@dense_1/kernel
?
dense_1/kernel/Adam_1/AssignAssigndense_1/kernel/Adam_1'dense_1/kernel/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*!
_class
loc:@dense_1/kernel
i
dense_1/kernel/Adam_1/readIdentitydense_1/kernel/Adam_1*
T0*!
_class
loc:@dense_1/kernel
?
3dense_1/bias/Adam/Initializer/zeros/shape_as_tensorConst*
valueB:*
dtype0*
_class
loc:@dense_1/bias
w
)dense_1/bias/Adam/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*
_class
loc:@dense_1/bias
?
#dense_1/bias/Adam/Initializer/zerosFill3dense_1/bias/Adam/Initializer/zeros/shape_as_tensor)dense_1/bias/Adam/Initializer/zeros/Const*
T0*

index_type0*
_class
loc:@dense_1/bias
?
dense_1/bias/Adam
VariableV2*
dtype0*
shared_name *
shape:*
	container *
_class
loc:@dense_1/bias
?
dense_1/bias/Adam/AssignAssigndense_1/bias/Adam#dense_1/bias/Adam/Initializer/zeros*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense_1/bias
_
dense_1/bias/Adam/readIdentitydense_1/bias/Adam*
T0*
_class
loc:@dense_1/bias
?
5dense_1/bias/Adam_1/Initializer/zeros/shape_as_tensorConst*
valueB:*
dtype0*
_class
loc:@dense_1/bias
y
+dense_1/bias/Adam_1/Initializer/zeros/ConstConst*
valueB
 *    *
dtype0*
_class
loc:@dense_1/bias
?
%dense_1/bias/Adam_1/Initializer/zerosFill5dense_1/bias/Adam_1/Initializer/zeros/shape_as_tensor+dense_1/bias/Adam_1/Initializer/zeros/Const*
T0*

index_type0*
_class
loc:@dense_1/bias
?
dense_1/bias/Adam_1
VariableV2*
dtype0*
shared_name *
shape:*
	container *
_class
loc:@dense_1/bias
?
dense_1/bias/Adam_1/AssignAssigndense_1/bias/Adam_1%dense_1/bias/Adam_1/Initializer/zeros*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense_1/bias
c
dense_1/bias/Adam_1/readIdentitydense_1/bias/Adam_1*
T0*
_class
loc:@dense_1/bias
7

Adam/beta1Const*
valueB
 *fff?*
dtype0
7

Adam/beta2Const*
valueB
 *w??*
dtype0
9
Adam/epsilonConst*
valueB
 *w?+2*
dtype0
?
2Adam/update_main_graph_0/hidden_0/kernel/ApplyAdam	ApplyAdammain_graph_0/hidden_0/kernel!main_graph_0/hidden_0/kernel/Adam#main_graph_0/hidden_0/kernel/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilonFgradients/main_graph_0/hidden_0/MatMul_grad/tuple/control_dependency_1*
T0*
use_locking( */
_class%
#!loc:@main_graph_0/hidden_0/kernel*
use_nesterov( 
?
0Adam/update_main_graph_0/hidden_0/bias/ApplyAdam	ApplyAdammain_graph_0/hidden_0/biasmain_graph_0/hidden_0/bias/Adam!main_graph_0/hidden_0/bias/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilonGgradients/main_graph_0/hidden_0/BiasAdd_grad/tuple/control_dependency_1*
T0*
use_locking( *-
_class#
!loc:@main_graph_0/hidden_0/bias*
use_nesterov( 
?
2Adam/update_main_graph_0/hidden_1/kernel/ApplyAdam	ApplyAdammain_graph_0/hidden_1/kernel!main_graph_0/hidden_1/kernel/Adam#main_graph_0/hidden_1/kernel/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilonFgradients/main_graph_0/hidden_1/MatMul_grad/tuple/control_dependency_1*
T0*
use_locking( */
_class%
#!loc:@main_graph_0/hidden_1/kernel*
use_nesterov( 
?
0Adam/update_main_graph_0/hidden_1/bias/ApplyAdam	ApplyAdammain_graph_0/hidden_1/biasmain_graph_0/hidden_1/bias/Adam!main_graph_0/hidden_1/bias/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilonGgradients/main_graph_0/hidden_1/BiasAdd_grad/tuple/control_dependency_1*
T0*
use_locking( *-
_class#
!loc:@main_graph_0/hidden_1/bias*
use_nesterov( 
?
2Adam/update_main_graph_0/hidden_2/kernel/ApplyAdam	ApplyAdammain_graph_0/hidden_2/kernel!main_graph_0/hidden_2/kernel/Adam#main_graph_0/hidden_2/kernel/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilonFgradients/main_graph_0/hidden_2/MatMul_grad/tuple/control_dependency_1*
T0*
use_locking( */
_class%
#!loc:@main_graph_0/hidden_2/kernel*
use_nesterov( 
?
0Adam/update_main_graph_0/hidden_2/bias/ApplyAdam	ApplyAdammain_graph_0/hidden_2/biasmain_graph_0/hidden_2/bias/Adam!main_graph_0/hidden_2/bias/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilonGgradients/main_graph_0/hidden_2/BiasAdd_grad/tuple/control_dependency_1*
T0*
use_locking( *-
_class#
!loc:@main_graph_0/hidden_2/bias*
use_nesterov( 
?
2Adam/update_main_graph_1/hidden_0/kernel/ApplyAdam	ApplyAdammain_graph_1/hidden_0/kernel!main_graph_1/hidden_0/kernel/Adam#main_graph_1/hidden_0/kernel/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilonFgradients/main_graph_1/hidden_0/MatMul_grad/tuple/control_dependency_1*
T0*
use_locking( */
_class%
#!loc:@main_graph_1/hidden_0/kernel*
use_nesterov( 
?
0Adam/update_main_graph_1/hidden_0/bias/ApplyAdam	ApplyAdammain_graph_1/hidden_0/biasmain_graph_1/hidden_0/bias/Adam!main_graph_1/hidden_0/bias/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilonGgradients/main_graph_1/hidden_0/BiasAdd_grad/tuple/control_dependency_1*
T0*
use_locking( *-
_class#
!loc:@main_graph_1/hidden_0/bias*
use_nesterov( 
?
2Adam/update_main_graph_1/hidden_1/kernel/ApplyAdam	ApplyAdammain_graph_1/hidden_1/kernel!main_graph_1/hidden_1/kernel/Adam#main_graph_1/hidden_1/kernel/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilonFgradients/main_graph_1/hidden_1/MatMul_grad/tuple/control_dependency_1*
T0*
use_locking( */
_class%
#!loc:@main_graph_1/hidden_1/kernel*
use_nesterov( 
?
0Adam/update_main_graph_1/hidden_1/bias/ApplyAdam	ApplyAdammain_graph_1/hidden_1/biasmain_graph_1/hidden_1/bias/Adam!main_graph_1/hidden_1/bias/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilonGgradients/main_graph_1/hidden_1/BiasAdd_grad/tuple/control_dependency_1*
T0*
use_locking( *-
_class#
!loc:@main_graph_1/hidden_1/bias*
use_nesterov( 
?
2Adam/update_main_graph_1/hidden_2/kernel/ApplyAdam	ApplyAdammain_graph_1/hidden_2/kernel!main_graph_1/hidden_2/kernel/Adam#main_graph_1/hidden_2/kernel/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilonFgradients/main_graph_1/hidden_2/MatMul_grad/tuple/control_dependency_1*
T0*
use_locking( */
_class%
#!loc:@main_graph_1/hidden_2/kernel*
use_nesterov( 
?
0Adam/update_main_graph_1/hidden_2/bias/ApplyAdam	ApplyAdammain_graph_1/hidden_2/biasmain_graph_1/hidden_2/bias/Adam!main_graph_1/hidden_2/bias/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilonGgradients/main_graph_1/hidden_2/BiasAdd_grad/tuple/control_dependency_1*
T0*
use_locking( *-
_class#
!loc:@main_graph_1/hidden_2/bias*
use_nesterov( 
?
"Adam/update_dense/kernel/ApplyAdam	ApplyAdamdense/kerneldense/kernel/Adamdense/kernel/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilon6gradients/dense/MatMul_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class
loc:@dense/kernel*
use_nesterov( 
?
 Adam/update_dense/bias/ApplyAdam	ApplyAdam
dense/biasdense/bias/Adamdense/bias/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilon7gradients/dense/BiasAdd_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class
loc:@dense/bias*
use_nesterov( 
?
'Adam/update_log_sigma_squared/ApplyAdam	ApplyAdamlog_sigma_squaredlog_sigma_squared/Adamlog_sigma_squared/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilongradients/AddN_4*
T0*
use_locking( *$
_class
loc:@log_sigma_squared*
use_nesterov( 
?
$Adam/update_dense_1/kernel/ApplyAdam	ApplyAdamdense_1/kerneldense_1/kernel/Adamdense_1/kernel/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilon8gradients/dense_1/MatMul_grad/tuple/control_dependency_1*
T0*
use_locking( *!
_class
loc:@dense_1/kernel*
use_nesterov( 
?
"Adam/update_dense_1/bias/ApplyAdam	ApplyAdamdense_1/biasdense_1/bias/Adamdense_1/bias/Adam_1beta1_power/readbeta2_power/readPolynomialDecay
Adam/beta1
Adam/beta2Adam/epsilon9gradients/dense_1/BiasAdd_grad/tuple/control_dependency_1*
T0*
use_locking( *
_class
loc:@dense_1/bias*
use_nesterov( 
?
Adam/mulMulbeta1_power/read
Adam/beta13^Adam/update_main_graph_0/hidden_0/kernel/ApplyAdam1^Adam/update_main_graph_0/hidden_0/bias/ApplyAdam3^Adam/update_main_graph_0/hidden_1/kernel/ApplyAdam1^Adam/update_main_graph_0/hidden_1/bias/ApplyAdam3^Adam/update_main_graph_0/hidden_2/kernel/ApplyAdam1^Adam/update_main_graph_0/hidden_2/bias/ApplyAdam3^Adam/update_main_graph_1/hidden_0/kernel/ApplyAdam1^Adam/update_main_graph_1/hidden_0/bias/ApplyAdam3^Adam/update_main_graph_1/hidden_1/kernel/ApplyAdam1^Adam/update_main_graph_1/hidden_1/bias/ApplyAdam3^Adam/update_main_graph_1/hidden_2/kernel/ApplyAdam1^Adam/update_main_graph_1/hidden_2/bias/ApplyAdam#^Adam/update_dense/kernel/ApplyAdam!^Adam/update_dense/bias/ApplyAdam(^Adam/update_log_sigma_squared/ApplyAdam%^Adam/update_dense_1/kernel/ApplyAdam#^Adam/update_dense_1/bias/ApplyAdam*
T0*
_class
loc:@dense/bias
}
Adam/AssignAssignbeta1_powerAdam/mul*
T0*
use_locking( *
validate_shape(*
_class
loc:@dense/bias
?

Adam/mul_1Mulbeta2_power/read
Adam/beta23^Adam/update_main_graph_0/hidden_0/kernel/ApplyAdam1^Adam/update_main_graph_0/hidden_0/bias/ApplyAdam3^Adam/update_main_graph_0/hidden_1/kernel/ApplyAdam1^Adam/update_main_graph_0/hidden_1/bias/ApplyAdam3^Adam/update_main_graph_0/hidden_2/kernel/ApplyAdam1^Adam/update_main_graph_0/hidden_2/bias/ApplyAdam3^Adam/update_main_graph_1/hidden_0/kernel/ApplyAdam1^Adam/update_main_graph_1/hidden_0/bias/ApplyAdam3^Adam/update_main_graph_1/hidden_1/kernel/ApplyAdam1^Adam/update_main_graph_1/hidden_1/bias/ApplyAdam3^Adam/update_main_graph_1/hidden_2/kernel/ApplyAdam1^Adam/update_main_graph_1/hidden_2/bias/ApplyAdam#^Adam/update_dense/kernel/ApplyAdam!^Adam/update_dense/bias/ApplyAdam(^Adam/update_log_sigma_squared/ApplyAdam%^Adam/update_dense_1/kernel/ApplyAdam#^Adam/update_dense_1/bias/ApplyAdam*
T0*
_class
loc:@dense/bias
?
Adam/Assign_1Assignbeta2_power
Adam/mul_1*
T0*
use_locking( *
validate_shape(*
_class
loc:@dense/bias
?
AdamNoOp3^Adam/update_main_graph_0/hidden_0/kernel/ApplyAdam1^Adam/update_main_graph_0/hidden_0/bias/ApplyAdam3^Adam/update_main_graph_0/hidden_1/kernel/ApplyAdam1^Adam/update_main_graph_0/hidden_1/bias/ApplyAdam3^Adam/update_main_graph_0/hidden_2/kernel/ApplyAdam1^Adam/update_main_graph_0/hidden_2/bias/ApplyAdam3^Adam/update_main_graph_1/hidden_0/kernel/ApplyAdam1^Adam/update_main_graph_1/hidden_0/bias/ApplyAdam3^Adam/update_main_graph_1/hidden_1/kernel/ApplyAdam1^Adam/update_main_graph_1/hidden_1/bias/ApplyAdam3^Adam/update_main_graph_1/hidden_2/kernel/ApplyAdam1^Adam/update_main_graph_1/hidden_2/bias/ApplyAdam#^Adam/update_dense/kernel/ApplyAdam!^Adam/update_dense/bias/ApplyAdam(^Adam/update_log_sigma_squared/ApplyAdam%^Adam/update_dense_1/kernel/ApplyAdam#^Adam/update_dense_1/bias/ApplyAdam^Adam/Assign^Adam/Assign_1
?
initNoOp^global_step/Assign^last_reward/Assign^running_mean/Assign^running_variance/Assign$^main_graph_0/hidden_0/kernel/Assign"^main_graph_0/hidden_0/bias/Assign$^main_graph_0/hidden_1/kernel/Assign"^main_graph_0/hidden_1/bias/Assign$^main_graph_0/hidden_2/kernel/Assign"^main_graph_0/hidden_2/bias/Assign$^main_graph_1/hidden_0/kernel/Assign"^main_graph_1/hidden_0/bias/Assign$^main_graph_1/hidden_1/kernel/Assign"^main_graph_1/hidden_1/bias/Assign$^main_graph_1/hidden_2/kernel/Assign"^main_graph_1/hidden_2/bias/Assign^dense/kernel/Assign^dense/bias/Assign^log_sigma_squared/Assign^dense_1/kernel/Assign^dense_1/bias/Assign^beta1_power/Assign^beta2_power/Assign)^main_graph_0/hidden_0/kernel/Adam/Assign+^main_graph_0/hidden_0/kernel/Adam_1/Assign'^main_graph_0/hidden_0/bias/Adam/Assign)^main_graph_0/hidden_0/bias/Adam_1/Assign)^main_graph_0/hidden_1/kernel/Adam/Assign+^main_graph_0/hidden_1/kernel/Adam_1/Assign'^main_graph_0/hidden_1/bias/Adam/Assign)^main_graph_0/hidden_1/bias/Adam_1/Assign)^main_graph_0/hidden_2/kernel/Adam/Assign+^main_graph_0/hidden_2/kernel/Adam_1/Assign'^main_graph_0/hidden_2/bias/Adam/Assign)^main_graph_0/hidden_2/bias/Adam_1/Assign)^main_graph_1/hidden_0/kernel/Adam/Assign+^main_graph_1/hidden_0/kernel/Adam_1/Assign'^main_graph_1/hidden_0/bias/Adam/Assign)^main_graph_1/hidden_0/bias/Adam_1/Assign)^main_graph_1/hidden_1/kernel/Adam/Assign+^main_graph_1/hidden_1/kernel/Adam_1/Assign'^main_graph_1/hidden_1/bias/Adam/Assign)^main_graph_1/hidden_1/bias/Adam_1/Assign)^main_graph_1/hidden_2/kernel/Adam/Assign+^main_graph_1/hidden_2/kernel/Adam_1/Assign'^main_graph_1/hidden_2/bias/Adam/Assign)^main_graph_1/hidden_2/bias/Adam_1/Assign^dense/kernel/Adam/Assign^dense/kernel/Adam_1/Assign^dense/bias/Adam/Assign^dense/bias/Adam_1/Assign^log_sigma_squared/Adam/Assign ^log_sigma_squared/Adam_1/Assign^dense_1/kernel/Adam/Assign^dense_1/kernel/Adam_1/Assign^dense_1/bias/Adam/Assign^dense_1/bias/Adam_1/Assign
8

save/ConstConst*
valueB Bmodel*
dtype0
?
save/SaveV2/tensor_namesConst*?
value?B?9Bbeta1_powerBbeta2_powerB
dense/biasBdense/bias/AdamBdense/bias/Adam_1Bdense/kernelBdense/kernel/AdamBdense/kernel/Adam_1Bdense_1/biasBdense_1/bias/AdamBdense_1/bias/Adam_1Bdense_1/kernelBdense_1/kernel/AdamBdense_1/kernel/Adam_1Bglobal_stepBlast_rewardBlog_sigma_squaredBlog_sigma_squared/AdamBlog_sigma_squared/Adam_1Bmain_graph_0/hidden_0/biasBmain_graph_0/hidden_0/bias/AdamB!main_graph_0/hidden_0/bias/Adam_1Bmain_graph_0/hidden_0/kernelB!main_graph_0/hidden_0/kernel/AdamB#main_graph_0/hidden_0/kernel/Adam_1Bmain_graph_0/hidden_1/biasBmain_graph_0/hidden_1/bias/AdamB!main_graph_0/hidden_1/bias/Adam_1Bmain_graph_0/hidden_1/kernelB!main_graph_0/hidden_1/kernel/AdamB#main_graph_0/hidden_1/kernel/Adam_1Bmain_graph_0/hidden_2/biasBmain_graph_0/hidden_2/bias/AdamB!main_graph_0/hidden_2/bias/Adam_1Bmain_graph_0/hidden_2/kernelB!main_graph_0/hidden_2/kernel/AdamB#main_graph_0/hidden_2/kernel/Adam_1Bmain_graph_1/hidden_0/biasBmain_graph_1/hidden_0/bias/AdamB!main_graph_1/hidden_0/bias/Adam_1Bmain_graph_1/hidden_0/kernelB!main_graph_1/hidden_0/kernel/AdamB#main_graph_1/hidden_0/kernel/Adam_1Bmain_graph_1/hidden_1/biasBmain_graph_1/hidden_1/bias/AdamB!main_graph_1/hidden_1/bias/Adam_1Bmain_graph_1/hidden_1/kernelB!main_graph_1/hidden_1/kernel/AdamB#main_graph_1/hidden_1/kernel/Adam_1Bmain_graph_1/hidden_2/biasBmain_graph_1/hidden_2/bias/AdamB!main_graph_1/hidden_2/bias/Adam_1Bmain_graph_1/hidden_2/kernelB!main_graph_1/hidden_2/kernel/AdamB#main_graph_1/hidden_2/kernel/Adam_1Brunning_meanBrunning_variance*
dtype0
?
save/SaveV2/shape_and_slicesConst*?
value|Bz9B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B *
dtype0
?
save/SaveV2SaveV2
save/Constsave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesbeta1_powerbeta2_power
dense/biasdense/bias/Adamdense/bias/Adam_1dense/kerneldense/kernel/Adamdense/kernel/Adam_1dense_1/biasdense_1/bias/Adamdense_1/bias/Adam_1dense_1/kerneldense_1/kernel/Adamdense_1/kernel/Adam_1global_steplast_rewardlog_sigma_squaredlog_sigma_squared/Adamlog_sigma_squared/Adam_1main_graph_0/hidden_0/biasmain_graph_0/hidden_0/bias/Adam!main_graph_0/hidden_0/bias/Adam_1main_graph_0/hidden_0/kernel!main_graph_0/hidden_0/kernel/Adam#main_graph_0/hidden_0/kernel/Adam_1main_graph_0/hidden_1/biasmain_graph_0/hidden_1/bias/Adam!main_graph_0/hidden_1/bias/Adam_1main_graph_0/hidden_1/kernel!main_graph_0/hidden_1/kernel/Adam#main_graph_0/hidden_1/kernel/Adam_1main_graph_0/hidden_2/biasmain_graph_0/hidden_2/bias/Adam!main_graph_0/hidden_2/bias/Adam_1main_graph_0/hidden_2/kernel!main_graph_0/hidden_2/kernel/Adam#main_graph_0/hidden_2/kernel/Adam_1main_graph_1/hidden_0/biasmain_graph_1/hidden_0/bias/Adam!main_graph_1/hidden_0/bias/Adam_1main_graph_1/hidden_0/kernel!main_graph_1/hidden_0/kernel/Adam#main_graph_1/hidden_0/kernel/Adam_1main_graph_1/hidden_1/biasmain_graph_1/hidden_1/bias/Adam!main_graph_1/hidden_1/bias/Adam_1main_graph_1/hidden_1/kernel!main_graph_1/hidden_1/kernel/Adam#main_graph_1/hidden_1/kernel/Adam_1main_graph_1/hidden_2/biasmain_graph_1/hidden_2/bias/Adam!main_graph_1/hidden_2/bias/Adam_1main_graph_1/hidden_2/kernel!main_graph_1/hidden_2/kernel/Adam#main_graph_1/hidden_2/kernel/Adam_1running_meanrunning_variance*G
dtypes=
;29
e
save/control_dependencyIdentity
save/Const^save/SaveV2*
T0*
_class
loc:@save/Const
?
save/RestoreV2/tensor_namesConst"/device:CPU:0*?
value?B?9Bbeta1_powerBbeta2_powerB
dense/biasBdense/bias/AdamBdense/bias/Adam_1Bdense/kernelBdense/kernel/AdamBdense/kernel/Adam_1Bdense_1/biasBdense_1/bias/AdamBdense_1/bias/Adam_1Bdense_1/kernelBdense_1/kernel/AdamBdense_1/kernel/Adam_1Bglobal_stepBlast_rewardBlog_sigma_squaredBlog_sigma_squared/AdamBlog_sigma_squared/Adam_1Bmain_graph_0/hidden_0/biasBmain_graph_0/hidden_0/bias/AdamB!main_graph_0/hidden_0/bias/Adam_1Bmain_graph_0/hidden_0/kernelB!main_graph_0/hidden_0/kernel/AdamB#main_graph_0/hidden_0/kernel/Adam_1Bmain_graph_0/hidden_1/biasBmain_graph_0/hidden_1/bias/AdamB!main_graph_0/hidden_1/bias/Adam_1Bmain_graph_0/hidden_1/kernelB!main_graph_0/hidden_1/kernel/AdamB#main_graph_0/hidden_1/kernel/Adam_1Bmain_graph_0/hidden_2/biasBmain_graph_0/hidden_2/bias/AdamB!main_graph_0/hidden_2/bias/Adam_1Bmain_graph_0/hidden_2/kernelB!main_graph_0/hidden_2/kernel/AdamB#main_graph_0/hidden_2/kernel/Adam_1Bmain_graph_1/hidden_0/biasBmain_graph_1/hidden_0/bias/AdamB!main_graph_1/hidden_0/bias/Adam_1Bmain_graph_1/hidden_0/kernelB!main_graph_1/hidden_0/kernel/AdamB#main_graph_1/hidden_0/kernel/Adam_1Bmain_graph_1/hidden_1/biasBmain_graph_1/hidden_1/bias/AdamB!main_graph_1/hidden_1/bias/Adam_1Bmain_graph_1/hidden_1/kernelB!main_graph_1/hidden_1/kernel/AdamB#main_graph_1/hidden_1/kernel/Adam_1Bmain_graph_1/hidden_2/biasBmain_graph_1/hidden_2/bias/AdamB!main_graph_1/hidden_2/bias/Adam_1Bmain_graph_1/hidden_2/kernelB!main_graph_1/hidden_2/kernel/AdamB#main_graph_1/hidden_2/kernel/Adam_1Brunning_meanBrunning_variance*
dtype0
?
save/RestoreV2/shape_and_slicesConst"/device:CPU:0*?
value|Bz9B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B *
dtype0
?
save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices"/device:CPU:0*G
dtypes=
;29
?
save/AssignAssignbeta1_powersave/RestoreV2*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/bias
?
save/Assign_1Assignbeta2_powersave/RestoreV2:1*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/bias
?
save/Assign_2Assign
dense/biassave/RestoreV2:2*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/bias
?
save/Assign_3Assigndense/bias/Adamsave/RestoreV2:3*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/bias
?
save/Assign_4Assigndense/bias/Adam_1save/RestoreV2:4*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/bias
?
save/Assign_5Assigndense/kernelsave/RestoreV2:5*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/kernel
?
save/Assign_6Assigndense/kernel/Adamsave/RestoreV2:6*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/kernel
?
save/Assign_7Assigndense/kernel/Adam_1save/RestoreV2:7*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense/kernel
?
save/Assign_8Assigndense_1/biassave/RestoreV2:8*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense_1/bias
?
save/Assign_9Assigndense_1/bias/Adamsave/RestoreV2:9*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense_1/bias
?
save/Assign_10Assigndense_1/bias/Adam_1save/RestoreV2:10*
T0*
use_locking(*
validate_shape(*
_class
loc:@dense_1/bias
?
save/Assign_11Assigndense_1/kernelsave/RestoreV2:11*
T0*
use_locking(*
validate_shape(*!
_class
loc:@dense_1/kernel
?
save/Assign_12Assigndense_1/kernel/Adamsave/RestoreV2:12*
T0*
use_locking(*
validate_shape(*!
_class
loc:@dense_1/kernel
?
save/Assign_13Assigndense_1/kernel/Adam_1save/RestoreV2:13*
T0*
use_locking(*
validate_shape(*!
_class
loc:@dense_1/kernel
?
save/Assign_14Assignglobal_stepsave/RestoreV2:14*
T0*
use_locking(*
validate_shape(*
_class
loc:@global_step
?
save/Assign_15Assignlast_rewardsave/RestoreV2:15*
T0*
use_locking(*
validate_shape(*
_class
loc:@last_reward
?
save/Assign_16Assignlog_sigma_squaredsave/RestoreV2:16*
T0*
use_locking(*
validate_shape(*$
_class
loc:@log_sigma_squared
?
save/Assign_17Assignlog_sigma_squared/Adamsave/RestoreV2:17*
T0*
use_locking(*
validate_shape(*$
_class
loc:@log_sigma_squared
?
save/Assign_18Assignlog_sigma_squared/Adam_1save/RestoreV2:18*
T0*
use_locking(*
validate_shape(*$
_class
loc:@log_sigma_squared
?
save/Assign_19Assignmain_graph_0/hidden_0/biassave/RestoreV2:19*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
save/Assign_20Assignmain_graph_0/hidden_0/bias/Adamsave/RestoreV2:20*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
save/Assign_21Assign!main_graph_0/hidden_0/bias/Adam_1save/RestoreV2:21*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_0/bias
?
save/Assign_22Assignmain_graph_0/hidden_0/kernelsave/RestoreV2:22*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
save/Assign_23Assign!main_graph_0/hidden_0/kernel/Adamsave/RestoreV2:23*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
save/Assign_24Assign#main_graph_0/hidden_0/kernel/Adam_1save/RestoreV2:24*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_0/kernel
?
save/Assign_25Assignmain_graph_0/hidden_1/biassave/RestoreV2:25*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
save/Assign_26Assignmain_graph_0/hidden_1/bias/Adamsave/RestoreV2:26*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
save/Assign_27Assign!main_graph_0/hidden_1/bias/Adam_1save/RestoreV2:27*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_1/bias
?
save/Assign_28Assignmain_graph_0/hidden_1/kernelsave/RestoreV2:28*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
save/Assign_29Assign!main_graph_0/hidden_1/kernel/Adamsave/RestoreV2:29*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
save/Assign_30Assign#main_graph_0/hidden_1/kernel/Adam_1save/RestoreV2:30*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_1/kernel
?
save/Assign_31Assignmain_graph_0/hidden_2/biassave/RestoreV2:31*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
save/Assign_32Assignmain_graph_0/hidden_2/bias/Adamsave/RestoreV2:32*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
save/Assign_33Assign!main_graph_0/hidden_2/bias/Adam_1save/RestoreV2:33*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_0/hidden_2/bias
?
save/Assign_34Assignmain_graph_0/hidden_2/kernelsave/RestoreV2:34*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
save/Assign_35Assign!main_graph_0/hidden_2/kernel/Adamsave/RestoreV2:35*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
save/Assign_36Assign#main_graph_0/hidden_2/kernel/Adam_1save/RestoreV2:36*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_0/hidden_2/kernel
?
save/Assign_37Assignmain_graph_1/hidden_0/biassave/RestoreV2:37*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
save/Assign_38Assignmain_graph_1/hidden_0/bias/Adamsave/RestoreV2:38*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
save/Assign_39Assign!main_graph_1/hidden_0/bias/Adam_1save/RestoreV2:39*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_0/bias
?
save/Assign_40Assignmain_graph_1/hidden_0/kernelsave/RestoreV2:40*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
save/Assign_41Assign!main_graph_1/hidden_0/kernel/Adamsave/RestoreV2:41*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
save/Assign_42Assign#main_graph_1/hidden_0/kernel/Adam_1save/RestoreV2:42*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_0/kernel
?
save/Assign_43Assignmain_graph_1/hidden_1/biassave/RestoreV2:43*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
save/Assign_44Assignmain_graph_1/hidden_1/bias/Adamsave/RestoreV2:44*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
save/Assign_45Assign!main_graph_1/hidden_1/bias/Adam_1save/RestoreV2:45*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_1/bias
?
save/Assign_46Assignmain_graph_1/hidden_1/kernelsave/RestoreV2:46*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
save/Assign_47Assign!main_graph_1/hidden_1/kernel/Adamsave/RestoreV2:47*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
save/Assign_48Assign#main_graph_1/hidden_1/kernel/Adam_1save/RestoreV2:48*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_1/kernel
?
save/Assign_49Assignmain_graph_1/hidden_2/biassave/RestoreV2:49*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
save/Assign_50Assignmain_graph_1/hidden_2/bias/Adamsave/RestoreV2:50*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
save/Assign_51Assign!main_graph_1/hidden_2/bias/Adam_1save/RestoreV2:51*
T0*
use_locking(*
validate_shape(*-
_class#
!loc:@main_graph_1/hidden_2/bias
?
save/Assign_52Assignmain_graph_1/hidden_2/kernelsave/RestoreV2:52*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
save/Assign_53Assign!main_graph_1/hidden_2/kernel/Adamsave/RestoreV2:53*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
save/Assign_54Assign#main_graph_1/hidden_2/kernel/Adam_1save/RestoreV2:54*
T0*
use_locking(*
validate_shape(*/
_class%
#!loc:@main_graph_1/hidden_2/kernel
?
save/Assign_55Assignrunning_meansave/RestoreV2:55*
T0*
use_locking(*
validate_shape(*
_class
loc:@running_mean
?
save/Assign_56Assignrunning_variancesave/RestoreV2:56*
T0*
use_locking(*
validate_shape(*#
_class
loc:@running_variance
?
save/restore_allNoOp^save/Assign^save/Assign_1^save/Assign_2^save/Assign_3^save/Assign_4^save/Assign_5^save/Assign_6^save/Assign_7^save/Assign_8^save/Assign_9^save/Assign_10^save/Assign_11^save/Assign_12^save/Assign_13^save/Assign_14^save/Assign_15^save/Assign_16^save/Assign_17^save/Assign_18^save/Assign_19^save/Assign_20^save/Assign_21^save/Assign_22^save/Assign_23^save/Assign_24^save/Assign_25^save/Assign_26^save/Assign_27^save/Assign_28^save/Assign_29^save/Assign_30^save/Assign_31^save/Assign_32^save/Assign_33^save/Assign_34^save/Assign_35^save/Assign_36^save/Assign_37^save/Assign_38^save/Assign_39^save/Assign_40^save/Assign_41^save/Assign_42^save/Assign_43^save/Assign_44^save/Assign_45^save/Assign_46^save/Assign_47^save/Assign_48^save/Assign_49^save/Assign_50^save/Assign_51^save/Assign_52^save/Assign_53^save/Assign_54^save/Assign_55^save/Assign_56
?
Const_4Const*?
value?B?BtrainerBppoB
batch_sizeB2048BbetaB0.005Bbuffer_sizeB10240BepsilonB0.2BgammaB0.99Bhidden_unitsB53BlambdB0.95Blearning_rateB0.001B	max_stepsB3e5Bmemory_sizeB256B	normalizeBTrueB	num_epochB3B
num_layersB3Btime_horizonB128Bsequence_lengthB64Bsummary_freqB1000Buse_recurrentBFalseBuse_curiosityBFalseBcuriosity_strengthB0.01Bcuriosity_enc_sizeB128Bgraph_scopeB Bsummary_pathB./summaries/Ant_4leg_My-0*
dtype0
K
Hyperparameters/tagConst* 
valueB BHyperparameters*
dtype0
\
+Hyperparameters/serialized_summary_metadataConst*
valueB B

text*
dtype0
v
HyperparametersTensorSummaryV2Hyperparameters/tagConst_4+Hyperparameters/serialized_summary_metadata*
T0"