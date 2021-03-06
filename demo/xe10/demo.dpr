{
  Copyright (c) 2020, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program demo;

uses
  Forms,
  InsensitiveTextMatch,
  TemplateLog,
  Log,
  MultipleLog,
  ConsoleLog,
  TemplateTextFileLog,
  MainForm in '..\code\form\MainForm.pas' {MainForm};

{$R *.res}

var
  Log: IMultipleLog;

begin
{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
{$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Log := TMultipleLog.New;
  Log.Logs.Add(TTemplateTextFileLog.New(TTemplateLog.New('{AppPath}demo_{Month}{Year}.log', TInsensitiveTextMatch.New),
    TTemplateLog.New('{IP}:{PC}-{User}-{App}[{LogLevel}]>>{DateTime} {TEXT}', TInsensitiveTextMatch.New)));
  Log.Logs.Add(TConsoleLog.New(nil));
  NewMainForm := TMainForm.New(Log);
  NewMainForm.ShowModal;
  Application.Run;

end.
