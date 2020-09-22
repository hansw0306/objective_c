# objective_c
objective-c project



- (void)OnDidNavigation:(WKWebView*)WebView withError:(NSError *)error Navigation:(WKNavigation *)navigation
{
    //NSLog(@"OnDidNavigation:withError");
    //인트로 화면을 제거해준다....
    [[MiapsFramework GetInstance] ShowLaunchView:NO StoryBoardID:nil];
      
//    //택스트 선태글 막는 방법....
//    NSString* sFunctionJS = @"var css = '*{-webkit-touch-callout:none;-webkit-user-select:none}'; var head = document.head || document.getElementsByTagName('head')[0]; var style = document.createElement('style'); style.type = 'text/css'; style.appendChild(document.createTextNode(css)); head.appendChild(style);";
//    [WebView evaluateJavaScript:sFunctionJS completionHandler:^(id _Nullable obj, NSError * _Nullable error)
//     {
//        if(error)
//        {
//        }
//        else
//        {
//        }
//    }];
}
