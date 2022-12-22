# garage-fsm

Specifications: -
- The Controller has 3 inputs: -
o Activate push button (user) trigger the Up motor when the
Door down and trigger the Down motor when the Door Up

o UP_Max (Sensor) becomes high when the Door is
completely open.

o DN_Max (Sensor) becomes high when the Door is
completely close.

o Always the Door is completely close or completely open.

o Finite state machine is initialized to IDLE state using
Asynchronous reset
