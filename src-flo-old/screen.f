C------------------------------------------------------------------------------
C Save the solution in various formats
C------------------------------------------------------------------------------
      subroutine screen(qc, cl, cd)
      implicit none
      include 'param.h'
      double precision qc(nvar,ntmax), cl, cd

      integer          ifile, ii, is, it, i
      double precision ft1(3), ft2(3), coort(2,3), val1(100), 
     &                 val2(100), delro1, delro2,
     &                 deltat, xx0, yy0, xx1, yy1, q2, mach, cp, ent, 
     &                 r, u, v, p
 
      pmin =  1.0d10
      pmax = -1.0d10
      mmin =  1.0d10
      mmax = -1.0d10
      rmin =  1.0d10
      rmax = -1.0d10
      umin =  1.0d10
      umax = -1.0d10
      vmin =  1.0d10
      vmax = -1.0d10
      emin =  1.0d10
      emax = -1.0d10
      do is=1,nt
          r    = qc(1,is)
          u    = qc(2,is)
          v    = qc(3,is)
          q2   = u**2 + v**2
          p    = qc(4,is)
          rmin = dmin1(rmin, r) 
          rmax = dmax1(rmax, r) 
          umin = dmin1(umin, u) 
          umax = dmax1(umax, u) 
          vmin = dmin1(vmin, v) 
          vmax = dmax1(vmax, v) 
          pmin = dmin1(pmin, p) 
          pmax = dmax1(pmax, p) 
          mach = dsqrt(q2*r/(GAMMA*p))
          mmin = dmin1(mmin, mach)
          mmax = dmax1(mmax, mach)
          ent  = dlog10(p/r**GAMMA/ent_inf)
          emin = dmin1(emin, ent)
          emax = dmax1(emax, ent)
      enddo

      write(*,9)('-',i=1,70)
9     format(70a)
      write(*,10)mach_inf,aoa_deg,Rey,CFL
10    format(' Mach =',f6.3,', AOA =',f6.2, ', Rey = ',e10.4,
     &       ', CFL = ',e10.4)
      write(*,11)iflux,ilimit,gridfile
11    format(' Flux =',i2, ',     Lim = ',i2,',    Grid= ',a30)
      write(*,9)('-',i=1,70)
      write(*,'(" Iterations        =",i12)')iter
      write(*,'(" Global dt         =",e16.6)') dtglobal
      write(*,'(" L2 residue        =",e16.6)')fres
      write(*,'(" Linf residue      =",e16.6)')fresi
      write(*,'(" Linf triangle     =",i12)') iresi
      write(*,*)
      write(*,'(" Cl, Cd            =",2f12.6)')cl,cd
      write(*,*)
      write(*,'(27x,"Min",8x,"Max")')          
      write(*,'(" Density           =",2f12.6)')rmin, rmax
      write(*,'(" Pressure          =",2f12.6)')pmin, pmax
      write(*,'(" Mach number       =",2f12.6)')mmin, mmax
      write(*,'(" x velocity        =",2f12.6)')umin, umax
      write(*,'(" y velocity        =",2f12.6)')vmin, vmax
      write(*,'(" Entropy           =",2f12.6)')emin, emax
      write(*,*)
      write(*,*)
      write(*,*)
      write(*,*)
      call flush(6)

      return
      end
