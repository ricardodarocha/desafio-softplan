unit Strategy;

interface

type
  IXmlContent = interface
    ['{D7B628D1-6CCF-402F-A950-03342A8D42DB}']
    function XmlContent: String;
  end;

  IJsonContent = interface
    ['{46CCE459-F1F9-4C8B-A7E7-64EA9C9952B6}']
    function JsonContent: String;
  end;

implementation

end.
