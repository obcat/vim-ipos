# vim-ipos

[![CI](https://github.com/obcat/vim-ipos/workflows/CI/badge.svg)](https://github.com/obcat/vim-ipos/actions?query=workflow%3Aci)
[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.txt)

![ipos-eyecatch](https://user-images.githubusercontent.com/64692680/121812633-89e2a680-cca3-11eb-8982-740b6683dd97.gif)

**vim-ipos** is a Vim plugin that provides features to jump to the position where the cursor was last time [*Insert-ish mode*](https://github.com/obcat/vim-ipos/blob/72243850ef7b149f39e071637a191cd9ba80ea0e/doc/ipos.txt#L66-L68) was started.

Concretely,

- A mark that points the position where the cursor was last time *Insert-ish mode* was started
- A key sequence to jump to that position and then start Insert mode

are contained. These features are similar to Vim's builtin ['^ mark](https://github.com/vim/vim/blob/7237cab8f1d1a4391372cafdb57f2d97f3b32d05/runtime/doc/motion.txt#L911-L915) and [gi command](https://github.com/vim/vim/blob/7237cab8f1d1a4391372cafdb57f2d97f3b32d05/runtime/doc/insert.txt#L1865-L1873), respectively.

Please see the [help file](doc/ipos.txt) for more information.
