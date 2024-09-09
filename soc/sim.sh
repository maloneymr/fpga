EXAMPLES_DIR=src
EXAMPLE=top

set -ex

#rm -rf build/
vir compile "$EXAMPLES_DIR/$EXAMPLE.vir"

iverilog -g2005-sv testbench.v $(ls build/*.v) cells/cells_sim.v -o "./build/$EXAMPLE"
"./build/$EXAMPLE"
