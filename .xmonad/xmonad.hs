import XMonad
import XMonad.Config.Kde
import XMonad.Hooks.ManageHelpers
import qualified XMonad.StackSet as W -- to shift and float windows

main = xmonad $ kde4Config

  { modMask = mod4Mask, -- use the Windows button as mod
    manageHook = manageHook kde4Config <+> myManageHook,
    terminal = "xterm",
    focusedBorderColor = "blue",
    focusFollowsMouse = False
  }
  where
    myManageHook = composeAll
      [
       -- Allow the following applets to be free-floating
       className =? "Wicd-client.py" --> doFloat,
       className =? "Kmix" --> doFloat,
       className =? "Plasma-desktop" --> doFloat,
       className =? "Plasma" --> doFloat,
       className =? "Xmessage" --> doFloat,
       className =? "Gxmessage" --> doFloat,
       className =? "Kcalc" --> doFloat,
       className =? "Gimp" --> doFloat,
       className =? "Gimp-2.6" --> doFloat
      ]
