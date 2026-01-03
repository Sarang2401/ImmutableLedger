resource "aws_cloudwatch_event_bus" "audit_bus" {
  name = "audit-events"
}

resource "aws_cloudwatch_event_rule" "all_events" {
  event_bus_name = aws_cloudwatch_event_bus.audit_bus.name
  event_pattern  = jsonencode({ "source": ["regulated.app"] })
}

resource "aws_cloudwatch_event_target" "to_lambda" {
  rule          = aws_cloudwatch_event_rule.all_events.name
  event_bus_name = aws_cloudwatch_event_bus.audit_bus.name
  arn           = aws_lambda_function.audit_writer.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.audit_writer.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.all_events.arn
}


