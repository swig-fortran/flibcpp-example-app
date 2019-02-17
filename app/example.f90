!-----------------------------------------------------------------------------!
! \file   app/example.f90
!
! Copyright (c) 2019 Oak Ridge National Laboratory, UT-Battelle, LLC.
! Distributed under an MIT open source license: see LICENSE for details.
!-----------------------------------------------------------------------------!

program example
  use, intrinsic :: ISO_C_BINDING
  use, intrinsic :: ISO_FORTRAN_ENV
  use :: example_backend
  character(len=*), parameter :: array_fmt = '(16i4)'

  write(output_unit,*) "Initializing..."
  call init(32)
  write(output_unit,array_fmt) example_array

  write(output_unit,*) "Filling with random numbers in [0,127]..."
  call randomize(0, 127)
  write(output_unit,array_fmt) example_array

  write(output_unit,*) "Sorting..."
  call sort()
  write(output_unit,array_fmt) example_array

  write(output_unit,*) "Shuffling..."
  call shuffle()
  write(output_unit,array_fmt) example_array

  write(output_unit,*) "Shuffling again..."
  call shuffle()
  write(output_unit,array_fmt) example_array

end program 

!-----------------------------------------------------------------------------!
! end of app/example.f90
!-----------------------------------------------------------------------------!
