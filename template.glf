package require PWI_Glyph 2.18.2

pw::Application setUndoMaximumLevels 5
pw::Application reset
pw::Application markUndoLevel {Journal Reset}

pw::Application clearModified

set _TMP(mode_1) [pw::Application begin GridImport]
  $_TMP(mode_1) initialize -strict -type {PLOT3D} {/home/neelappagouda/PROJECT/final/airfoil.x}
  $_TMP(mode_1) read
  $_TMP(mode_1) convert
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Import Grid}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  set _CN(1) [pw::GridEntity getByName con-1]
  set _CN(2) [pw::GridEntity getByName con-2]
  $_TMP(PW_1) addPoint [$_CN(1) getPosition -arc 1]
  $_TMP(PW_1) addPoint [$_CN(2) getPosition -arc 1]
  set _CN(3) [pw::Connector create]
  $_CN(3) addSegment $_TMP(PW_1)
  unset _TMP(PW_1)
  $_CN(3) calculateDimension
$_TMP(mode_1) end
unset _TMP(mode_1)
pw::Application markUndoLevel {Create 2 Point Connector}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::SegmentSpline create]
  $_TMP(PW_1) delete
  unset _TMP(PW_1)
$_TMP(mode_1) abort
unset _TMP(mode_1)
$_CN(3) setDimension 4
pw::CutPlane refresh
pw::Application markUndoLevel {Dimension}

set _TMP(mode_1) [pw::Application begin Create]
  set _TMP(PW_1) [pw::Edge createFromConnectors [list $_CN(2) $_CN(1) $_CN(3)]]
  set _TMP(edge_1) [lindex $_TMP(PW_1) 0]
  unset _TMP(PW_1)
  set _DM(1) [pw::DomainStructured create]
  $_DM(1) addEdge $_TMP(edge_1)
$_TMP(mode_1) end
unset _TMP(mode_1)
set _TMP(mode_1) [pw::Application begin ExtrusionSolver [list $_DM(1)]]
  $_TMP(mode_1) setKeepFailingStep true
  $_DM(1) setExtrusionSolverAttribute NormalInitialStepSize 0.001
  $_DM(1) setExtrusionSolverAttribute NormalMarchingVector {-0 -0 -1}
  $_TMP(mode_1) run 100
  $_TMP(mode_1) end
unset _TMP(mode_1)
unset _TMP(edge_1)
pw::Application markUndoLevel {Extrude, Normal}

pw::Display zoomToFit -animate 1

# Appended by Pointwise V18.2R2 - Thu Aug  8 19:41:37 2019

pw::Application setCAESolver {CGNS} 2
pw::Application markUndoLevel {Set Dimension 2D}

set _CN(4) [pw::GridEntity getByName con-5]
set _CN(5) [pw::GridEntity getByName con-4]
set _TMP(PW_1) [pw::BoundaryCondition getByName Unspecified]
set _TMP(PW_2) [pw::BoundaryCondition create]
pw::Application markUndoLevel {Create BC}

set _TMP(PW_3) [pw::BoundaryCondition getByName bc-2]
unset _TMP(PW_2)
$_TMP(PW_3) setName airfoil
pw::Application markUndoLevel {Name BC}

$_TMP(PW_3) setPhysicalType -usage CAE {Wall Inviscid}
pw::Application markUndoLevel {Change BC Type}

$_TMP(PW_3) apply [list [list $_DM(1) $_CN(2)] [list $_DM(1) $_CN(1)] [list $_DM(1) $_CN(3)]]
pw::Application markUndoLevel {Set BC}

set _TMP(PW_4) [pw::BoundaryCondition create]
pw::Application markUndoLevel {Create BC}

set _TMP(PW_5) [pw::BoundaryCondition getByName bc-3]
unset _TMP(PW_4)
$_TMP(PW_5) setName farfield
pw::Application markUndoLevel {Name BC}

$_TMP(PW_5) setPhysicalType -usage CAE Farfield
pw::Application markUndoLevel {Change BC Type}

$_TMP(PW_5) apply [list [list $_DM(1) $_CN(4)]]
pw::Application markUndoLevel {Set BC}

unset _TMP(PW_1)
unset _TMP(PW_3)
unset _TMP(PW_5)
set _TMP(PW_1) [pw::VolumeCondition create]
pw::Application markUndoLevel {Create VC}

$_TMP(PW_1) setName fluid
pw::Application markUndoLevel {Name VC}

$_TMP(PW_1) setPhysicalType Fluid
pw::Application markUndoLevel {Change VC Type}

$_TMP(PW_1) apply [list $_DM(1)]
pw::Application markUndoLevel {Set VC}

unset _TMP(PW_1)
pw::Application setCAESolverAttribute {CGNS.FileType} {adf}
pw::Application setCAESolverAttribute {ExportPolynomialDegree} {Q1}
pw::Application setCAESolverAttribute {ExportWCNWeightingFactorMode} {Calculate}
pw::Application setCAESolverAttribute {ExportWCNWeightingFactorMode} {Calculate}
pw::Application markUndoLevel {Set Solver Attributes}


set _TMP(mode_1) [pw::Application begin CaeExport [pw::Entity sort [list $_DM(1)]]]
  $_TMP(mode_1) initialize -strict -type CAE {/home/neelappagouda/PROJECT/final/SU2_solution/airfoil_updated.cgns}
  $_TMP(mode_1) setAttribute FilePrecision Double
  $_TMP(mode_1) setAttribute GridStructuredAsUnstructured true
  $_TMP(mode_1) setAttribute ExportParentElements true
  $_TMP(mode_1) verify
  $_TMP(mode_1) write
$_TMP(mode_1) end
unset _TMP(mode_1)
