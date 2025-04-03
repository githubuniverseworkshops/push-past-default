/**
 * @id u2024/ghsl-2022-077
 * @name URL redirect in DataHub
 * @problem.severity error
 * @security-severity 7
 * @kind path-problem
 */

/*
 * Default query:
 * Copied from https://github.com/github/codeql/blob/main/java/ql/src/Security/CWE/CWE-601/UrlRedirect.ql
 */

import java
import semmle.code.java.dataflow.DataFlow
import semmle.code.java.security.UrlRedirectQuery
import UrlRedirectFlow::PathGraph

from UrlRedirectFlow::PathNode source, UrlRedirectFlow::PathNode sink
where UrlRedirectFlow::flowPath(source, sink)
select sink.getNode(), source, sink, "Untrusted URL redirection depends on a $@.", source.getNode(),
  "user-provided value"
