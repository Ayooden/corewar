#!/bin/bash

RED="\x1b[31m"
GREEN="\x1b[32m"
YELLOW="\x1b[33m"
RESET="\x1b[0m"

COREWAR_EXEC=$1

CHAMPS_DIR=checkers/valid_champs
DIFF_DIR=checkers/diff_files

TEST_TMP=test_temp_my

ERRORS_REPORT=checkers/check_inputs_report.txt

print_ok()
{
	printf "${GREEN}%s${RESET}" "$1"
}

print_error()
{
	printf "${RED}%s${RESET}" "$1"
}

print_warning()
{
	printf "${YELLOW}%s${RESET}" "$1"
}

run_all_tests()
{
  for file in `find ${DIFF_DIR} -type f -name "*.txt"`
  do
    local name=`echo ${file%%.*} | cut -d'/' -f3`
    ${COREWAR_EXEC} ${CHAMPS_DIR}/${name}.cor > ${TEST_TMP}
    local output=`diff -ibB ${TEST_TMP} ${file}`
    printf "%-65s" "${name}.cor"
    printf ": "
    if [ "$output" = "" ]; then
      print_ok "Good!"
    else
      print_error "Booo!"
      echo  "$file" >>  ${ERRORS_REPORT}
      echo  "\n" >>  ${ERRORS_REPORT}
      echo  "$output" >>  ${ERRORS_REPORT}
      echo  "\n" >>  ${ERRORS_REPORT}
      echo "----------------------\n" >>  ${ERRORS_REPORT}
    fi
    printf "\n"
  done
}

print_usage_and_exit()
{
	printf "%s\n" "Usage: ./check_errors.sh exec"
	printf "%s\n" "  -exec   Path to executable"
	exit
}

if [ $# -ne 1 ];then
	print_usage_and_exit
	exit
fi

if [ ! -f $1 ];then
	printf "%s\n" "Executable ($1) not found"
	exit
fi

echo "" > ${ERRORS_REPORT}

run_all_tests

rm $TEST_TMP
#rm $DEMO_OUTPUT
