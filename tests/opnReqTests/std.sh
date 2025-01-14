set -eu

if [[ $application == 'global' ]]; then
  if [[ $CI_TEST == 'true' ]]; then
    INPES=3
    JNPES=2
    WRITE_GROUP=1
    WRTTASK_PER_GROUP=12
    TASKS=$((INPES*JNPES*6 + WRITE_GROUP*WRTTASK_PER_GROUP))
  fi
  RESTART_N=$(( FHMAX/2 ))
  RESTART_INTERVAL="${RESTART_N} -1"
elif [[ $application == 'regional' ]]; then
  if [[ $CI_TEST == 'true' ]]; then
    INPES=4
    JNPES=6
    TASKS=$((INPES*JNPES))
  fi
elif [[ $application == 'cpld' ]]; then
  if [ $CI_TEST == 'true' ]; then
    INPES=2
    JNPES=2
    NPROC_ICE=6
    med_petlist_bounds="0 23"
    atm_petlist_bounds="0 29"
    ocn_petlist_bounds="30 39"
    ice_petlist_bounds="40 45"
    TASKS=$((INPES*JNPES*6 + WRITE_GROUP*WRTTASK_PER_GROUP + 10 + 6))
  fi
  RESTART_N=$(( FHMAX/2 ))
  RESTART_INTERVAL="${RESTART_N} -1"
fi

NODES=$(((TASKS+TPN-1)/TPN))
(test $CI_TEST == 'true') && source $PATHRT/opnReqTests/cmp_proc_bind.sh
if [[ $RT_SUFFIX =~ std ]]; then
  source $PATHRT/opnReqTests/wrt_env.sh
fi
