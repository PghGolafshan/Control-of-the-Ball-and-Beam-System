# Control-of-the-Ball-and-Beam-System
Modeled the ball‑and‑beam system with two degrees of freedom: beam angle (θ) and the ball’s position on the beam.
## Problem Definition

The Ball and Beam system is shown in the figure below. By applying an angle \( \theta \), the position of one end of the beam can be controlled. Assuming the other end of the beam is fixed to the ground, the position of the ball on the beam can be tracked. The system has two degrees of freedom: the angle of the beam and the position of the ball along the beam. The goal is to control the position of the ball on the beam. The control input is \( \theta \).

### Assumptions:
- The ball rolls without slipping on the beam.
- The displacement relationship between the right end of the beam and the angle \( \theta \) is approximated as:  
  \[
  \alpha = \frac{d}{L} \theta \,\, \text{(1)}
  \]
- The mass of the beam and arm is neglected for calculating kinetic energy.
- External forces such as friction and losses are ignored, and only gravitational force is considered.

![Ball and Beam Image](https://github.com/PghGolafshan/Control-of-the-Ball-and-Beam-System/blob/main/Screenshot%202025-10-25%20140724.png?raw=true)
