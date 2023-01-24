# HapticsDemo
A demo project to depict haptics feedback usage as well as view shaking

### Haptics

This class acts as a wrapper for 3 prime use cases:

**1. UINotificationFeedbackGenerator:**
  Use `Haptics.notify(_:)`
  
**2. UIImpactFeedbackGenerator:**
  Use `Haptics.markImpact(intensity:)`
  
**3. UISelectionFeedbackGenerator:**
  Use `Haptics.selectionEffect()`


### ShakableView

- This protocol helps you to make your views shakable
- Conform your views to this protocol to make them shakable.
- Then simply call `view.shake()`.
