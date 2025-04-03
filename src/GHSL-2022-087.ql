/**
 * @id u2024/ghsl-2022-087
 * @name Cypher injection in DataHub
 * @problem.severity error
 * @security-severity 7
 * @kind path-problem
 */

/*
 * Custom query
 */

import java
import semmle.code.java.dataflow.DataFlow
import semmle.code.java.security.SqlInjectionQuery

module CypherInjectionFlowConfig implements DataFlow::ConfigSig {
  predicate isSource(DataFlow::Node src) { src instanceof RemoteFlowSource }

  predicate isSink(DataFlow::Node dst) { dst instanceof QueryInjectionSink }
}

module CypherInjectionFlow = TaintTracking::Global<CypherInjectionFlowConfig>;

import CypherInjectionFlow::PathGraph

from CypherInjectionFlow::PathNode source, CypherInjectionFlow::PathNode sink
where CypherInjectionFlow::flowPath(source, sink)
select sink.getNode(), source, sink, "Direct query concatenation"
